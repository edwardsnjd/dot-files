" Protect against multiple loading
if exists('g:loaded_refactoring')
  finish
endif
let g:loaded_refactoring = 1

" Inline
" NOTE: Uses i and j registers, and i and j marks.
" Implementation deletes the target to @i and copies the variable name to @j
" then sets up a change to replace the variable with the target before deleting
" the declaration line(s).  Much of this is to cater for multiline values.
nmap <Plug>(RefactoringInlineWord) viw<Plug>(RefactoringInlineSelection)
xnoremap <Plug>(RefactoringInlineSelection) 
      \:<C-U>'< mark i<CR>
      \:<C-U>'>+1 mark j<CR>
      \gv
      \"id
      \F=BviW
      \"jy
      \gv
      \:<C-U>let @/ = '\V'.escape(@j, '\') <BAR> set hls <CR>
      \cgni<Esc>
      \:'i,'j-1 delete<CR>
      \n
      \:echo 'Press . to replace each '.@j.' usage with '.@i<CR>
