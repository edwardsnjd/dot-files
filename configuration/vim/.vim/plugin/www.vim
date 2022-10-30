" Protect against multiple loading
if exists('g:loaded_www')
  finish
endif
let g:loaded_www = 1

" Create commands
command! -nargs=* SearchWeb silent exec "! ddg ".shellescape(<q-args>) | redraw!
command! -nargs=* SearchDevDocs silent exec "! open https://devdocs.io/\\#q=".shellescape(<q-args>) | redraw!
command! -nargs=* SearchDictionary exec "! define ".shellescape(<q-args>)
command! -nargs=* SearchThesaurus exec "! thesaurus ".shellescape(<q-args>)
