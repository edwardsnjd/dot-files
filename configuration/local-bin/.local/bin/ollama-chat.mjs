#! /usr/bin/env node

import { createInterface } from 'readline'

const OLLAMA_HOST = 'http://127.0.0.1:11434'
const END_OF_INPUT_MARKER = '.'

const DEFAULT_MODEL = 'llama3.2'

// OLLAMA: Requests

const buildChat = (model, messages = [], format = '', options = {}) => ({
  format,
  messages,
  model,
  options,
})

const buildMessage = (content, role) => ({ content, role })

const appendUserMessage = (chat, content) =>
  appendMessage(chat, buildMessage(content, 'user'))

const appendAssistantMessage = (chat, content) =>
  appendMessage(chat, buildMessage(content, 'assistant'))

const appendMessage = (chat, message) => ({
  ...chat,
  messages: [...chat.messages, message],
})

// CLI

const buildPrompt = (input, output) => {
  const rl = createInterface({ input, output })
  return (query) => new Promise((resolve) => rl.question(query, resolve))
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

  const handleUserInput = async (userContent) => {
    chat = appendUserMessage(chat, userContent)

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
    while (true) {
      const line = await prompt('')
      if (line == END_OF_INPUT_MARKER) break
      lines.push(line)
    }
    return lines.join('\n')
  }

  mainLoop:
  while (true) {
    console.log('*🤔 User*')
    const userContent = await getUserInput()

    switch (userContent) {
      case 'exit':
        console.log("(exiting)")
        break mainLoop

      case '/clear':
        resetChat()
        console.log("(chat has been reset)")
        console.log()
        break

      default:
        console.log('*🤖 Assistant*')
        await handleUserInput(userContent)
        console.log() // don't overwrite response
        console.log()
    }
  }
}

(async function() {
  const model = process.env.MODEL || DEFAULT_MODEL
  await start(model)
})()
