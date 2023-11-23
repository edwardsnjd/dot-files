#! /usr/bin/env bash

echo "
You are an experienced full-stack software developer.

Add inline comments for any complex code.

Reply as code not markdown.

CODE:
$(cat)

CODE WITH INLINE COMMENTS:
" | ollama run codellama:7b
