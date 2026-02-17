" Wrapper that calls the original MarkdownFold() but suppresses folds in code.
function! MyMarkdownFoldWrapper() abort
  if s:MyMarkdownIsInSnippet(v:lnum)
    return '='
  else
    return MarkdownFold()
  endif
endfunction

function! s:MyMarkdownIsInSnippet(lnum) abort
  let ids = synstack(a:lnum, 1)
  let names = map(ids, 'synIDattr(v:val, "name")')
  let snippet_names = filter(names, 'v:val =~# "^markdownCode\|^markdownHighlight\|^mkdSnippet"')
  return !empty(snippet_names)
endfunction

setlocal foldmethod=expr
setlocal foldexpr=MyMarkdownFoldWrapper() " improved
setlocal foldtext=MarkdownFoldText()      " original

" Restore default values
let b:undo_ftplugin = "setlocal"
