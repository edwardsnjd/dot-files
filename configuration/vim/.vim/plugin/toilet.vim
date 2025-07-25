" Protect against multiple loading
if exists('g:loaded_toilet')
  finish
endif
let g:loaded_toilet = 1

nnoremap <Plug>(ToiletBig)      :.!toilet -W -w 300 -f big      -d ~/.config/toilet/figlet-fonts<CR>
nnoremap <Plug>(ToiletStandard) :.!toilet -W -w 300 -f standard -d ~/.config/toilet/figlet-fonts<CR>
nnoremap <Plug>(ToiletFuture)   :.!toilet -W -w 300 -f future<CR>
nnoremap <Plug>(ToiletPagga)    :.!toilet -W -w 300 -f pagga<CR>
nnoremap <Plug>(ToiletBorder)   :.!toilet    -w 300 -f term -F border<CR>
