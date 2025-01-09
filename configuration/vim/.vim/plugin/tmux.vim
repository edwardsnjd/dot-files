" Protect against multiple loading
if exists('g:loaded_tmux')
  finish
endif
let g:loaded_tmux = 1

nnoremap <Plug>(TmuxSendRight)  :silent . write ! tmux-send .right<CR>:echo 'Sent to tmux'<CR>
xnoremap <Plug>(TmuxSendRightSelect) "xy:echo system('tmux-send .right', getreg('x'))<CR>:echo 'Sent to tmux'<CR>
nnoremap <Plug>(TmuxCopy)       :. write ! tmux load-buffer -<CR>:echo 'Copied to tmux'<CR>
xnoremap <Plug>(TmuxCopySelect) "xy:echo system('tmux load-buffer -', getreg('x'))<CR>:echo 'Copied to tmux'<CR>
nnoremap <Plug>(TmuxPasteBelow) :    read ! tmux show-buffer <CR>:echo 'Pasted from tmux'<CR>
nnoremap <Plug>(TmuxPasteAbove) :.-1 read ! tmux show-buffer<CR>:echo 'Pasted from tmux'<CR>
