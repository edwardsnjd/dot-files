---
name: web-search
description: Search the web for answers
---
# Searching the web

## When to use this skill
Use this skill when you need recent answers to a web search.

## How to find answers
1. Use the `web-search` CLI tool

## Examples
You can either pipe a prompt/question to the tool:
```bash
echo "What is the capital of France?" | web-search
```

Or provide the prompt/question as arguments to the tool, optionally quoting:
```bash
web-search What is the capital of France?
web-search "What is the capital of France?"
```
...
