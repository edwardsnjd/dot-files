" Provides support for finding imported modules via an external script and
" caching the results for performance.
"
" Vim's includeexpr is called on each line but scheme modules are imported
" using a syntax that can span multiple lines.  The work around is to use an
" external script to parse the whole buffer and find all the imports, then
" cache the results in a buffer variable.
"
" DEPENDENCIES:
" - scheme-imports.scm: command to find imports from scheme on stdin

setlocal include=^\\s*(use-modules
setlocal includeexpr=s:SchemeIncludeExpr(v:fname)
setlocal suffixesadd=.scm
setlocal define=define

function! s:SchemeIncludeExpr(fname) abort
  let index = s:SchemeModuleIndex()
  let key = s:SchemeModuleKey()
  return has_key(index, key) ? index[key] : a:fname
endfunction

" Build and cache an index of all the imported modules in this buffer.
" Invalidate this cache every buffer change.
function! s:SchemeModuleIndex() abort
  if exists('b:scheme_module_index')
        \ && exists('b:scheme_module_tick')
        \ && b:scheme_module_tick ==# b:changedtick
    return b:scheme_module_index
  endif

  let b:scheme_module_index = s:BuildModuleMap()
  let b:scheme_module_tick = b:changedtick

  return b:scheme_module_index
endfunction

" Build a map of imported modules from dotted module key to relative path
function! s:BuildModuleMap() abort
  let index = {}

  " Send whole buffer content to script to find imports
  let input = join(getline(1, '$'), "\n")
  let output = system('scheme-imports', input)

  for line in split(output, '\n')
    if line ==# ''
      continue
    endif
    " Example line: (acceptance-tests basic-file-serving)
    let s = substitute(line, '^[[:space:]]*(', '', '')
    let s = substitute(s, ')[[:space:]]*$', '', '')
    let parts = split(s)
    if !empty(parts)
      let key = join(parts, '.')
      let rel = join(parts, '/')
      let index[key] = rel
    endif
  endfor

  " echom index
  return index
endfunction

" Try to find a module key to look up from the current line
function! s:SchemeModuleKey() abort
  let line = getline('.')
  let col = col('.')
  let before = strpart(line, 0, col)
  let open_pos = strridx(before, '(')
  let close_pos = match(line, ')', col - 1)

  let parts = []
  if open_pos >= 0 && close_pos > open_pos
    " Example line: (acceptance-tests basic-file-serving)
    let sexp = strpart(line, open_pos + 1, close_pos - open_pos - 1)
    let parts = split(sexp)
  endif

  return empty(parts) ? expand('<cword>') : join(parts, '.')
endfunction

" Restore default values
let b:undo_ftplugin = "setlocal"
