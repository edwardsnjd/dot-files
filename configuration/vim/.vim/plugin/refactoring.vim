" Protect against multiple loading
if exists('g:loaded_refactoring')
  finish
endif
let g:loaded_refactoring = 1

" Inline operator
" NOTE: Uses i and j registers, and i and j marks.
nnoremap <expr> <Plug>(RefactoringInline) refactoring#InlineOperator()
xnoremap <expr> <Plug>(RefactoringInline) refactoring#InlineOperator()
