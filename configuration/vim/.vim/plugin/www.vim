" Protect against multiple loading
if exists('g:loaded_www')
  finish
endif
let g:loaded_www = 1

" Create commands
command! -nargs=* SearchWeb        silent exec "! ddg ".shellescape(<q-args>) | redraw!
command! -nargs=* SearchDevDocs    silent exec "! open https://devdocs.io/\\#q=".shellescape(<q-args>)
command! -nargs=* SearchDictionary silent exec "! define ".shellescape(<q-args>)." | less" | redraw!
command! -nargs=* SearchThesaurus  silent exec "! thesaurus ".shellescape(<q-args>)." | less" | redraw!

" Mappings:
" NOTE: Current selection ones use x register
nnoremap <Plug>(SearchDevDocsCurrentWord) :SearchDevDocs <C-R>=expand('<cword>')<CR><CR>
xnoremap <Plug>(SearchDevDocsSelection) "xy:<C-U>SearchDevDocs <C-R>=getreg('x')<CR><CR>
nnoremap <Plug>(SearchWebCurrentWord) :SearchWeb <C-R>=expand('<cword>')<CR><CR>
xnoremap <Plug>(SearchWebSelection) "xy:<C-U>SearchWeb <C-R>=getreg('x')<CR><CR>
nnoremap <Plug>(SearchDictionaryCurrentWord) :SearchDictionary <C-R>=expand('<cword>')<CR><CR>
nnoremap <Plug>(SearchThesaurusCurrentWord) :SearchThesaurus <C-R>=expand('<cword>')<CR><CR>
