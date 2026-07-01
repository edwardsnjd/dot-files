---
name: web-access
description: Search the web or fetch web pages
---
# Accessing the web

There are two different types of web access: search, or fetch.

> IMPORTANT: none of `web-access`, `web-search`, or `web-fetch` are tools you
> can invoke.
> - `web-access` is the NAME of this skill (documentation only).
> - `web_search` / `web_fetch` (with an UNDERSCORE) are native tools — call
>   them directly ONLY if they appear in your tool list.
> - `web-search` / `web-fetch` (with a HYPHEN) are shell commands — you run
>   them by making a `bash` tool call, e.g. `bash` with
>   `command: web-search "..."`. They are never invoked as tools directly.

How to pick what to use (in order):
1. If a native tool named `web_search` / `web_fetch` is in your tool list,
   call it directly.
2. Otherwise, use the `bash` tool to run the corresponding shell command
   (`web-search` / `web-fetch`).

If neither the native tool nor `bash` is available, tell the user you cannot
access the web rather than inventing a tool call.

## Searching the web

Do this when:
- you are asked to find/search/research something other than local files
- you need recent information

### How to search the web

1. If the native `web_search` tool is in your tool list, call it directly.
2. Otherwise, make a `bash` tool call that runs the `web-search` shell
   command, quoting the whole query as a single argument. The `bash`
   command string is exactly:

   ```
   web-search "C# console app testing best practices"
   ```

## Fetching a web page

Do this when:
- you need to fetch a specific web page or URL

### How to fetch a web page

1. If the native `web_fetch` tool is in your tool list, call it directly.
2. Otherwise, make a `bash` tool call that runs the `web-fetch` shell
   command with the URL as a single argument. The `bash` command string is
   exactly:

   ```
   web-fetch "https://example.com/article"
   ```
