" Set code navigation options
setlocal include=\\v(^import\|:)\ \\zs[a-zA-Z0-9_.]+\\ze
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

  " List all candidate file names to look for (split id on dots)
  let l:parts = v:fname->split('\.')
  let l:ids = range(len(l:parts))
        \ ->map({ idx -> join(l:parts[0 : l:idx], '.') })
        \ ->reverse()

  " Find the package name from the `package ...` line
  " HACK: Assume always first line of kotlin file
  let l:package = getbufoneline('%', 1)
        \ ->substitute('package ', '', '')

  " Check longest prefix first, bare, then in implicit package
  let l:candidateClasses = l:ids + copy(l:ids)->map('l:package .. "." .. v:val')

  " Return first one found
  for l:candidate in l:candidateClasses
    let l:relativePath = substitute(l:candidate, '\.', '/', 'g') .. &l:suffixesadd
    let l:foundPath = globpath(&path, l:relativePath)
    if len(l:foundPath)
      return l:foundPath
    endif
  endfor

  " Otherwise return nothing
  return
endfunction

" Restore default values
let b:undo_ftplugin = "setlocal include< define< suffixesadd< includeexpr<"
