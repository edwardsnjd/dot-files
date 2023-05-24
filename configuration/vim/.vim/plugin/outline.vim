" Protect against multiple loading
if exists('g:loaded_outline')
  finish
endif
let g:loaded_outline = 1

" Override/supplement this global variable to configure the keywords
" that cause a line to be included in the outline
let g:outline_filetype_keywords = {
      \ 'ruby': ['module', 'class', 'def', 'describe', 'context', 'it'],
      \ 'kotlin': ['class', 'object', 'fun'],
      \ 'vim': ['function'],
      \ 'rust': ['mod', 'fn', 'trait', 'impl'],
      \ 'javascript': ['function', 'class', 'export', 'describe', 'context', 'test', 'it'],
      \ 'typescript': ['function', 'class', 'type', 'enum', 'export', 'describe', 'context', 'test', 'it'],
      \ 'typescriptreact': ['function', 'class', 'type', 'enum', 'export', 'describe', 'context', 'test', 'it'],
      \}

" Provide commands and mappings calling autoloaded functions
nnoremap <Plug>(ShowLocalOutline) :call outline#ShowLocalOutline()<CR>
nnoremap <Plug>(ShowOutline) :call outline#ShowOutline()<CR>
