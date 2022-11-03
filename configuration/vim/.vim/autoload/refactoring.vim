" Inline
"
" NOTE: Uses i and j registers, and i and j marks.
"
" Implementation deletes the target to @i and copies the variable name to @j
" then sets up a change to replace the variable with the target before deleting
" the declaration line(s).  Much of this is to cater for multiline values.
"
" The mapping uses an expression to create a custom operator function so that
" the `g@` command can be repeatedly called, but the operator function can do
" a different thing for the first, or subsequent invocations.

function! refactoring#InlineOperator() abort
  let s:readyToReplaceUsages = 0
  let &operatorfunc = function('<SID>Inline')
  return 'g@'
endfunction

function! <SID>Inline(type) abort
  if s:readyToReplaceUsages == 0
    call <SID>InlineDeleteDefinition(a:type)
  else
    call <SID>InlineNextUsage()
  endif
  echo 'Press . to replace each '.@j.' usage with '.substitute(@i, "\n", "§", "g")
endfunction

function! <SID>InlineDeleteDefinition(type) abort
  " Mark definition lines and capture value
  if a:type ==# 'v'
    '< mark i
    '>+1 mark j

    normal! `<v`>"id
  elseif a:type ==# 'char'
    '[ mark i
    ']+1 mark j

    normal! `[v`]"id
  else
    return
  endif

  " Capture name
  normal! F=BviW
  normal! "jd

  " Set search to name
  let @/ = @j
  set hls

  " Delete entire definition
  'i,'j-1 delete

  let s:readyToReplaceUsages = 1
endfunction

function! <SID>InlineNextUsage() abort
  execute "normal cgni"
endfunction
