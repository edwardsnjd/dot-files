" Set keywords
setlocal iskeyword+=-

" Find import/include statements
let &l:include = '\v\s*#(import|include)'

" Restore default values
let b:undo_ftplugin = "setlocal iskeyword< include<"
