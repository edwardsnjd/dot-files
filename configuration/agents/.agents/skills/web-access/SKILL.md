---
name: web-access
description: Use this skill to search the web for up to date information or fetch web pages
---

# Accessing the web

There are two different types of web access: search, or fetch.

## Searching the web

Do this when:
- you are asked to find/search/research something other than local files
- you need recent information

### How to search the web

Make a `bash` tool call that runs the `web-search` shell command, quoting the whole query as a single argument. Example:

```bash
web-search "C# console app testing best practices"
```

## Fetching a web page

Do this when:
- you need to fetch a specific web page or URL

### How to fetch a web page

Make a `bash` tool call that runs the `web-fetch` shell command with the URL as a single argument.  Example:

```bash
web-fetch "https://example.com/article"
```
