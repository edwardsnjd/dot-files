#! /usr/bin/env node

import { runChatLoop, readStream } from './core-chat.mjs'

const DEFAULT_BASE_URL = 'http://127.0.0.1:11434/v1'
const DEFAULT_MODEL = 'llama3.2'

const SSE_PREFIX = 'data: '
const SSE_PREFIX_LENGTH = SSE_PREFIX.length
const DONE_MARKER = `${SSE_PREFIX}[DONE]`

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

function extractContent(line) {
  // Final line is special
  if (line === DONE_MARKER) return ''

  const data = stripAnyPrefix(line)
  const json = tryParseJson(data)

  // Ignore text lines
  if (!json) return ''

  if (json.error) throw json.error

  return extractChunkContent(json)
}

const tryParseJson = line => {
  try {
    return JSON.parse(line)
  } catch {
    return null
  }
}

const stripAnyPrefix = line =>
  line.startsWith(SSE_PREFIX) ? line.slice(SSE_PREFIX_LENGTH) : line

function extractChunkContent(response) {
  const content = response.choices?.[0]?.delta?.content

  if (!content) return ''

  if (typeof content === 'string') return content

  if (Array.isArray(content)) {
    return content
      .filter(part => part.type === 'text')
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
    for await (const contentChunk of readStream(response.body, extractContent)) {
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
  console.error('ERROR:', error.stack || error.message)
  process.exit(1)
})
