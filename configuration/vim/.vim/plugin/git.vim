" Protect against multiple loading
if exists('g:loaded_git')
  finish
endif
let g:loaded_git = 1

vnoremap <Plug>GitReplaceWithPerson :call git#ReplaceWithPerson()<CR>
