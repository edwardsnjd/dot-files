" Wrapper that calls the original MarkdownFold() but suppresses folds in code.
function! s:MarkdownFoldWrapper() abort
  return s:InSnippet(v:lnum) ? '=' : MarkdownFold()
endfunction

function! s:InSnippet(lnum) abort
  let ids = synstack(a:lnum, 1)
  let names = map(ids, 'synIDattr(v:val, "name")')
  let snippet_names = filter(names, 'v:val =~# "\\v^(markdownCode|markdownHighlight|mkdSnippet)"')
  return !empty(snippet_names)
endfunction

setlocal foldmethod=expr
setlocal foldexpr=s:MarkdownFoldWrapper() " improved
setlocal foldtext=MarkdownFoldText()        " original

" Restore default values
let b:undo_ftplugin = "setlocal"
