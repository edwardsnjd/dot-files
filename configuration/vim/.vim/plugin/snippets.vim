" Protect against multiple loading
if exists('g:loaded_snippets')
  finish
endif
let g:loaded_snippets = 1

nnoremap <Plug>SnippetsInsert :call snippets#Insert()<cr>
