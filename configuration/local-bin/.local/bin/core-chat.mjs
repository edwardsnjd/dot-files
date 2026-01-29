import { createInterface } from 'readline'
import { readFileSync, readdirSync } from 'fs'
import * as path from 'path'

const CLEAR_COMMAND = '/clear'
const DUMP_COMMAND = '/dump'
const FILE_COMMAND = '/file '
const IMAGE_COMMAND = '/image '
const EXIT_COMMAND = 'exit'

// Prompt management

function buildPrompt(input, output) {
  const rl = createInterface({ input, output, completer })
  return (query) => new Promise((resolve) => rl.question(query, resolve))
}

// completer :: String -> [Command[], String]
function completer(line) {
  if (line.length === 0 || line === '/') return [
    [CLEAR_COMMAND, DUMP_COMMAND, FILE_COMMAND, IMAGE_COMMAND],
    line,
  ]

  if (CLEAR_COMMAND.startsWith(line)) return [[CLEAR_COMMAND], line]
  if (DUMP_COMMAND.startsWith(line)) return [[DUMP_COMMAND], line]
  if (FILE_COMMAND.startsWith(line)) return [[FILE_COMMAND], line]
  if (IMAGE_COMMAND.startsWith(line)) return [[IMAGE_COMMAND], line]

  if (line.startsWith(FILE_COMMAND)) {
    const fileInput = line.substring(FILE_COMMAND.length)
    return [(filesMatching(fileInput)).map(r => `${FILE_COMMAND}${r}`), line]
  }

  if (line.startsWith(IMAGE_COMMAND)) {
    const fileInput = line.substring(IMAGE_COMMAND.length)
    return [(filesMatching(fileInput)).map(r => `${IMAGE_COMMAND}${r}`), line]
  }

  return [[], line]
}

function filesMatching(line) {
  const input = line.trim()
  const [dir, prefix] = input.endsWith(path.sep)
    ? [input, '']
    : [path.dirname(input), path.basename(input)]

  try {
    return readdirSync(path.resolve(dir), { withFileTypes: true })
      .filter(entry => entry.name.startsWith(prefix))
      .map(entry => entry.isDirectory() ? `${entry.name}${path.sep}` : entry.name)
      .map(entry => path.join(dir, entry))
  } catch (e) {
    return []
  }
}

const identity = (x) => x

export async function* readStream(body, transform = identity) {
  for await (const line of readLines(body)) {
    if (line === '') continue
    yield transform(line)
  }
}

async function* readLines(body) {
  const decoder = new TextDecoder()
  const matcher = /\r?\n/

  let partialLine = ''

  for await (const chunk of body) {
    // Add chunk to already collected partial line
    const str = decoder.decode(chunk, { stream: true })
    partialLine += str

    // Identify any complete lines
    const parts = partialLine.split(matcher)
    partialLine = parts.pop() // keep last line to collect more chunks

    // Yield complete lines
    for (const line of parts) {
      yield line
    }
  }

  // Yield last line
  yield partialLine
}

export async function getUserInput(prompt) {
  const lines = []
  const images = []
  while (true) {
    const line = await prompt('')
    if (line === '') break
    if (line.startsWith(FILE_COMMAND)) {
      const filePath = line.substring(FILE_COMMAND.length).trim()
      lines.push(filePath)
      lines.push(readFileSync(filePath, 'utf-8'))
      console.log(`(added file ${filePath})`)
    } else if (line.startsWith(IMAGE_COMMAND)) {
      const filePath = line.substring(IMAGE_COMMAND.length).trim()
      images.push(readFileSync(filePath).toString('base64'))
      console.log(`(added image ${filePath})`)
    } else {
      lines.push(line)
    }
  }
  return { lines, images }
}

// Chat history

function emptyMessages() {
  return []
}

function buildMessage(role, content = '', attachments = []) {
  return { role, content, attachments }
}

function appendUserMessage(messages, content, images) {
  const attachments = images.map(data => ({ type: 'image_base64', data }))
  return [...messages, buildMessage('user', content, attachments)]
}

function appendAssistantMessage(messages, content) {
  return [...messages, buildMessage('assistant', content)]
}

// Main chat loop
export async function runChatLoop(sendMessage) {
  let messages = emptyMessages()

  const resetChat = () => { messages = emptyMessages() }

  const handleUserInput = async (userContent, images) => {
    messages = appendUserMessage(messages, userContent, images)

    const chunks = await sendMessage(messages)

    let assistantContent = ''
    for await (const chunk of chunks) {
      assistantContent += chunk
      process.stdout.write(chunk)
      process.stdout.uncork() // Flush
    }

    messages = appendAssistantMessage(messages, assistantContent)
  }

  const prompt = buildPrompt(process.stdin, process.stderr)

  mainLoop:
  while (true) {
    console.log('*🤔 User*')
    const { lines, images } = await getUserInput(prompt)

    const userContent = lines.join('\n')

    switch (userContent) {
      case EXIT_COMMAND:
        console.log('(exiting)')
        break mainLoop

      case CLEAR_COMMAND:
        resetChat()
        console.log('(chat has been reset)')
        console.log()
        break

      case DUMP_COMMAND:
        console.log('(dumping chat)')
        console.log('```json')
        console.log(JSON.stringify(messages, null, 2))
        console.log('```')
        console.log()
        break

      default:
        console.log('*🤖 Assistant*')
        await handleUserInput(userContent, images)
        console.log()
        console.log()
    }
  }

  return messages
}
