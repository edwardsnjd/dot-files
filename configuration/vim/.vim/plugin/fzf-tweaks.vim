" Protect against multiple loading
if exists('g:loaded_fzftweaks')
  finish
endif
let g:loaded_fzftweaks = 1

" Configuration:

" Enlarge default fzf popup
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.9 } }

" Preview above the list
let g:fzf_preview_window = ['up:40%:border-bottom', 'ctrl-/']

" Commands:

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

" Custom :Session command
command! -bang -nargs=? Sessions call fzf#run(fzf#wrap(
      \ {
            \ 'dir': '~/sessions',
            \ 'source': 'ls *.vim',
            \ 'sink': function('<sid>LoadSession'),
            \ 'options': ['--prompt=Session> ', '--query', <q-args>]
      \ },
      \ <bang>0
      \))
function! s:LoadSession(session)
  let session_file = '~/sessions/'.a:session
  echom 'Restoring session: <'.session_file.'>'
  bufdo bd
  execute 'source '.session_file
endfunction

" Mappings:

" NOTE: Current selection ones use x register
" NOTE: Use `expand(<cword>)` because `<C-R><C-W>` will not type text that's already
" there, which will match the "b" from the leading "\b"!
nnoremap <Plug>(FzfSessions) :Sessions<CR>
nnoremap <Plug>(FzfFiles) :Files<CR>
nnoremap <Plug>(FzfBuffers) :Buffers<CR>
nnoremap <Plug>(FzfHistory) :HISTORY<CR>

nnoremap <Plug>(FzfBufferLines) :BSLines<CR>
nnoremap <Plug>(FzfBufferLinesCurrentWord) :BSLines <C-R>=expand('<cword>')<CR><CR>
xnoremap <Plug>(FzfBufferLinesSelection) "xy:<C-U>BSLines =escape(getreg('x'), '\()[]+*{}^$')<CR><CR>

nnoremap <Plug>(FzfBufferTags) :BTags<CR>
nnoremap <Plug>(FzfBufferTagsCurrentWord) :BTags <C-R>=expand('<cword>')<CR><CR>
xnoremap <Plug>(FzfBufferTagsSelection) "xy:<C-U>BTags <C-R>=escape(getreg('x'), '\()[]+*{}^$')<CR><CR>

nnoremap <Plug>(FzfText) :RG 
nnoremap <Plug>(FzfTextCurrentWord) :RG \b<C-R>=expand('<cword>')<CR>\b<CR>
xnoremap <Plug>(FzfTextSelection) "xy:<C-U>RG <C-R>=escape(getreg('x'), '\()[]+*{}^$')<CR><CR>
