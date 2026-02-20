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
setlocal includeexpr=join(split(v:fname),'/')
setlocal suffixesadd=.scm

" Restore default values
let b:undo_ftplugin = "setlocal include< includeexpr< suffixesadd<"
