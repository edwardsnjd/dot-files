" Protect against multiple loading
if exists('g:loaded_syntaxexplorer')
  finish
endif
let g:loaded_syntaxexplorer = 1

" Provide commands and mappings calling autoloaded functions
noremap <silent> <Plug>(SyntaxexplorerAtCursor) :call syntaxexplorer#AtCursor()<CR>
noremap <silent> <Plug>(SyntaxexplorerStackAtCursor) :call syntaxexplorer#StackAtCursor()<CR>
noremap <silent> <Plug>(SyntaxexplorerResync) :syntax sync fromstart <BAR> echo 'Resynced syntax highlighting'<CR>
