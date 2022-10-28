" Show highlight groups at the cursor
" See: https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
function! syntaxexplorer#AtCursor()
  echo 
        \ 'hi<'    . synIDattr(synID(line("."),col("."),1),"name") . '> ' .
        \ 'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> ' .
        \ 'lo<'    . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'
endfunction

" Show current syntax
function! syntaxexplorer#StackAtCursor()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
