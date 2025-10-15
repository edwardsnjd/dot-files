#! /usr/bin/env node

import { createInterface } from 'readline'
import { readFileSync, readdirSync } from 'fs'
import * as path from 'path'

const OLLAMA_HOST = 'http://127.0.0.1:11434'
const DEFAULT_MODEL = 'llama3.2'

const CLEAR_COMMAND = '/clear'
const DUMP_COMMAND = '/dump'
const FILE_COMMAND = '/file '
const IMAGE_COMMAND = '/image '

// OLLAMA: Requests

const buildChat = (model, messages = [], format = '', options = {}) => ({
  format,
  messages,
  model,
  options,
})

const buildMessage = (content, role, extras = {}) => ({ content, role, ...extras })

const appendUserMessage = (chat, content, images) =>
  appendMessage(chat, buildMessage(content, 'user', { images }))

const appendAssistantMessage = (chat, content) =>
  appendMessage(chat, buildMessage(content, 'assistant'))

const appendMessage = (chat, message) => ({
  ...chat,
  messages: [...chat.messages, message],
})

// CLI

const buildPrompt = (input, output) => {
  const rl = createInterface({ input, output, completer })
  return (query) => new Promise((resolve) => rl.question(query, resolve))
}

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

// HTTP

async function send(chat) {
  const chatUrl = `${OLLAMA_HOST}/api/chat`
  return await fetch(chatUrl, {
    method: 'POST',
    body: JSON.stringify(chat),
  })
}

async function* readJsonStream(body) {
  for await (const line of readLines(body)) {
    if (line) {
      yield JSON.parse(line)
    }
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

// APP

async function start(model) {
  let chat = buildChat(model)

  const resetChat = () => { chat = buildChat(model) }

  const handleUserInput = async (userContent, images) => {
    chat = appendUserMessage(chat, userContent, images)

    const httpResponse = await send(chat)

    let assistantContent = ''
    for await (const partialMessage of readJsonStream(httpResponse.body)) {
      const { message: { content } } = partialMessage

      assistantContent += content

      process.stdout.write(content)
      process.stdout.uncork() // Flush
    }

    chat = appendAssistantMessage(chat, assistantContent)
  }

  const prompt = buildPrompt(process.stdin, process.stderr)

  const getUserInput = async () => {
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

  mainLoop:
  while (true) {
    console.log('*🤔 User*')
    const { lines, images } = await getUserInput()

    const userContent = lines.join('\n')

    switch (userContent) {
      case 'exit':
        console.log("(exiting)")
        break mainLoop

      case CLEAR_COMMAND:
        resetChat()
        console.log("(chat has been reset)")
        console.log()
        break

      case DUMP_COMMAND:
        console.log("(dumping chat)")
        console.log('```json')
        console.log(JSON.stringify(chat, null, 2))
        console.log('```')
        console.log()
        break

      default:
        console.log('*🤖 Assistant*')
        await handleUserInput(userContent, images)
        console.log() // don't overwrite response
        console.log()
    }
  }
}

(async function() {
  const model = process.env.MODEL || DEFAULT_MODEL
  await start(model)
})()
