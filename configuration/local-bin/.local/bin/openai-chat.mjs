#! /usr/bin/env node

import { runChatLoop, readSseJsonStream } from './core-chat.mjs'

const DEFAULT_BASE_URL = 'http://127.0.0.1:11434/v1'
const DEFAULT_MODEL = 'llama3.2'

function requireEnv(name) {
  const value = process.env[name]
  if (!value) throw new Error(`Missing required environment variable ${name}`)
  return value
}

function oaiRequest(model, messages) {
  return {
    model,
    messages: messages.map(oaiMessage),
    stream: true,
  }
}

function oaiMessage(message) {
  const { role, content: text = '', attachments = [] } = message

  const textContent = text ? oaiText(text) : null
  const imageContents = attachments
    .filter(attachment => attachment.type === 'image_base64')
    .map(attachment => oaiImage(attachment.data))

  const content = [ textContent, ...imageContents ].filter(Boolean)

  return { role, content }
}
const oaiText = (text) => ({ type: 'text', text })
const oaiImage = (base64) => ({ type: 'image_url', image_url: { url: `data:image/jpeg;base64,${base64}` } })

function extractChunkContent(jsonChunk) {
  const choice = jsonChunk?.choices?.[0]?.delta
  if (!choice) return ''

  const { content } = choice
  if (!content) return ''

  if (typeof content === 'string') return content
  if (Array.isArray(content)) {
    return content
      .filter(part => part?.type === 'text' && part?.text)
      .map(part => part.text)
      .join('')
  }

  return ''
}

async function send(baseUrl, apiKey, chat) {
  const url = `${baseUrl}/chat/completions`
  return await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify(chat),
  })
}

function createSendMessage(baseUrl, apiKey, model) {
  return async function*(messages) {
    const chat = oaiRequest(model, messages)
    const response = await send(baseUrl, apiKey, chat)
    for await (const contentChunk of readSseJsonStream(response.body, extractChunkContent)) {
      if (contentChunk) yield contentChunk
    }
  }
}

(async function() {
  const baseUrl = process.env.OPENAI_BASE_URL || DEFAULT_BASE_URL
  const apiKey = process.env.OPENAI_API_KEY || ''
  const model = process.env.MODEL || DEFAULT_MODEL
  const sendMessage = createSendMessage(baseUrl, apiKey, model)
  await runChatLoop(sendMessage)
})().catch(error => {
  console.error(error.stack || error.message)
  process.exit(1)
})
