" Protect against multiple loading
if exists('g:loaded_presenter')
  finish
endif
let g:loaded_presenter = 1

" Provide commands and mappings calling autoloaded functions
noremap <Plug>PresenterPresent :call presenter#Present()<CR>
