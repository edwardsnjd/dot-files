" Set code navigation options
setlocal include=\\v(^import\ \|:\ )\\zs[a-zA-Z0-9_.]+\\ze
setlocal define=\\vclass\|fun\|interface
setlocal suffixesadd=.kt
setlocal includeexpr=s:KotlinIncludeExpr()

let s:kotlin_include_stop_words = [
      \ 'String', 'Int', 'Throwable', 'Long', 'List',
      \ 'Array', 'Map', 'Instant', 'Boolean'
      \ ]

" A function that accepts matched "include" lines and
" returns the file path
function! s:KotlinIncludeExpr()
  " PERFORMANCE: Short circuit to avoid checking stop words
  if index(s:kotlin_include_stop_words, v:fname) >= 0
    return
  endif

  " List all candidate class names to look for (longest first, look
  " for prefixes)
  let l:ids = []
  let l:parts = split(v:fname, '\.')
  let l:idx = len(l:parts) - 1
  while l:idx >= 0
    let l:candidate = join(l:parts[0 : l:idx], '.')
    call add(l:ids, l:candidate)
    let l:idx -= 1
  endwhile

  " Find the package name from the `package ...` line
  let l:package = substitute(getbufoneline('%', 1) , 'package ', '', '')

  " Check longest prefix first, bare, then in implicit package
  let l:candidateClasses = map(copy(l:ids), 'l:package .. "." .. v:val') + l:ids

  " Stop as soon as we find one
  for l:candidate in l:candidateClasses
    let l:relativePath = s:ConvertIdToRelativePath(l:candidate)
    let l:foundPath = globpath(&path, l:relativePath)
    if len(l:foundPath)
      return l:foundPath
    endif
  endfor
endfunction

" Convert dotted class identifiers to relative paths
function! s:ConvertIdToRelativePath(id)
  return substitute(a:id, '\.', '/', 'g') .. &l:suffixesadd
endfunction

" Restore default values
let b:undo_ftplugin = "setlocal include< define< suffixesadd< includeexpr<"
