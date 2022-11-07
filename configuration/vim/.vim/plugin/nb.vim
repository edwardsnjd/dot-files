" Protect against multiple loading
if exists('g:loaded_nb')
  finish
endif
let g:loaded_nb = 1

nnoremap <Plug>(NbInsertLink) :call nb#InsertLink()<CR>
