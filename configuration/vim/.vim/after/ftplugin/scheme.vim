" KNOWN ISSUES:
" - Doesn't support includes defined across multiple lines.  Vim's includeexpr
"   is called on each line but scheme modules are imported using a syntax that
"   can span multiple lines.

let &l:include =
      \ '\v' .
      \ '(' . '\(load\s+"\zs[^"]*\ze"'           . ')|' .
      \ '(' . '\(load-from-path\s+"\zs[^"]+\ze"' . ')|' .
      \ '(' . '\(use-modules\s+\(\zs[^()]+\ze\)' . ')|' .
      \ '(' . '#:use-module\s+\(\zs[^()]+\ze\)'  . ')'
setlocal includeexpr=s:SchemeIncludeExpr()
setlocal suffixesadd=.scm

function! s:SchemeIncludeExpr() abort
  let index = s:SchemeModuleIndex()
  let key = s:SchemeModuleKey(v:fname)
  return has_key(index, key) ? index[key] : v:fname
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

" Try to find a module key to look up from the matched include
function! s:SchemeModuleKey(fname) abort
  " Example line: acceptance-tests basic-file-serving
  let parts = split(a:fname)
  return join(parts, '.')
endfunction

" Restore default values
let b:undo_ftplugin = "setlocal include< includeexpr< suffixesadd<"
