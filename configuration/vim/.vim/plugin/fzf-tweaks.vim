" Protect against multiple loading
if exists('g:loaded_fzftweaks')
  finish
endif
let g:loaded_fzftweaks = 1

" Enlarge default fzf popup
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.9 } }

" Preview above the list
let g:fzf_preview_window = ['up:40%:border-bottom', 'ctrl-/']

" Improve :Rg command to include hidden files
command! -bang -nargs=* RG call fzf#vim#grep(
      \ "rg --column --line-number --no-heading --color=always --smart-case --hidden -- ".shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview({'options': ['--exact']}),
      \ <bang>0
      \)

" Alternate :BLines command with all lines in order
command! -bang -nargs=* BSLines call fzf#vim#buffer_lines(
      \ <q-args>,
      \ { 'options': ['--no-sort', '--query', len(split(<q-args>)) ? split(<q-args>)[0].' ' : '' ] },
      \ <bang>0
      \)

" Alternate :History command with all lines in order
command! -bang -nargs=* HISTORY call fzf#vim#history({ 'options': ['--no-sort'] }, <bang>0)
