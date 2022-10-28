" Switch to presentation mode, with minimal chrome
function! presenter#Present()
  set noruler noshowcmd norelativenumber nonumber noshowmode nohidden nocursorline
  set listchars= laststatus=0 shortmess=F
  set scrolloff=0
  GitGutterDisable
  nnoremap <silent> <Right> :bn<CR>
  nnoremap <silent> <Left> :bp<CR>
  nnoremap <Up> <nop>
  nnoremap <Down> <nop>
endfunction
