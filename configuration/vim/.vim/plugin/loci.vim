" Protect against multiple loading
if exists('g:loaded_loci')
  finish
endif
let g:loaded_loci = 1

" Create commands
command! -complete=file -nargs=1 ReadLociFile call loci#ReadLociFile(<f-args>)
command! -complete=file -nargs=1 WriteLociFile call loci#WriteLociFile(<f-args>)

" Create mappings
nnoremap <Plug>(LociAdd) :caddexpr loci#GetLocation()<CR>
nnoremap <Plug>(LociClear) :cexpr [] <bar> cclose<CR>
nnoremap <Plug>(LociRead) :ReadLociFile
nnoremap <Plug>(LociWrite) :WriteLociFile
