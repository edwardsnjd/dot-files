#! /usr/bin/env node

import { runChatLoop, readStream } from './core-chat.mjs'

const OLLAMA_HOST = 'http://127.0.0.1:11434'
const DEFAULT_MODEL = 'llama3.2'

// OLLAMA: Requests
//
// POST /api/chat:
// {
//   "model": "llama3.2",
//   "messages": [
//     { "role": "user", "content": "why is the sky blue?" },
//     { "role": "user", "content": "what is this?", images: ["<base64>"] }
//   ],
//   "stream": true
// }
//
// Streaming response:
// {
//   "model": "llama3.2",
//   "created_at": "2023-08-04T08:52:19.385406455-07:00",
//   "message": {
//     "role": "assistant",
//     "content": "The"
//   },
//   "done": false
// }
//
// (Final chunk includes statistics and sets "done": true)

function ollamaRequest(model, messages) {
  return {
    model,
    messages: messages.map(ollamaMessage),
    format: '',
    options: {}
  }
}

function ollamaMessage(message) {
  const { attachments = [], ...rest } = message
  const images = attachments
    .filter(attachment => attachment.type === 'image_base64')
    .map(attachment => attachment.data)
  return { ...rest, images }
}

function extractContent(line) {
  const { message } = JSON.parse(line)
  return message?.content ?? ''
}

async function send(host, chat) {
  const chatUrl = `${host}/api/chat`
  return await fetch(chatUrl, {
    method: 'POST',
    body: JSON.stringify(chat),
  })
}

function createSendMessage(host, model) {
  return async function(messages) {
    const ollamaChat = ollamaRequest(model, messages)
    const httpResponse = await send(host, ollamaChat)
    return readStream(httpResponse.body, extractContent)
  }
}

(async function() {
  const host = process.env.OLLAMA_HOST || OLLAMA_HOST
  const model = process.env.MODEL || DEFAULT_MODEL
  const sendMessage = createSendMessage(host, model)
  await runChatLoop(sendMessage)
})().catch(error => {
  console.error('ERROR:', error.stack || error.message)
  process.exit(1)
})
