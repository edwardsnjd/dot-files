" Protect against multiple loading
if exists('g:loaded_syntaxexplorer')
  finish
endif
let g:loaded_syntaxexplorer = 1

" Provide commands and mappings calling autoloaded functions
noremap <Plug>(SyntaxexplorerAtCursor) :call syntaxexplorer#AtCursor()<CR>
noremap <Plug>(SyntaxexplorerStackAtCursor) :call syntaxexplorer#StackAtCursor()<CR>
