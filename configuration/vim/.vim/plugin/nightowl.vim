" Protect against multiple loading
if exists('g:loaded_nightowl')
  finish
endif
let g:loaded_nightowl = 1

" Tweak the night-owl colours:
" hi Normal guifg=#d6deeb ctermfg=253 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
" hi Comment guifg=#637777 ctermfg=243 gui=italic cterm=italic
" hi IncSearch guifg=#eeeeee ctermfg=255 guibg=#ecc48d ctermbg=222 gui=NONE cterm=NONE
" hi Search guifg=#011627 ctermfg=233 guibg=#ecc48d ctermbg=222 gui=NONE cterm=NONE
" hi Todo guifg=#777777 ctermfg=243 guibg=#ecc48d ctermbg=222 gui=NONE cterm=NONE
" hi SpecialKey guifg=#ecc48d ctermfg=222 gui=NONE cterm=NONE
" hi diffAdded guifg=#addb67 ctermfg=149 gui=NONE cterm=NONE
" hi diffRemoved guifg=#ff5874 ctermfg=204 gui=NONE cterm=NONE
" hi ColorColumn guibg=#222222 ctermbg=235 gui=NONE cterm=NONE
" - Tone down the search highlighting
hi IncSearch  guibg=#a3cccc guifg=#607080
hi Search     guibg=#404040 guifg=#d6deeb
" - Tone down the TODO highlight
hi Todo       guibg=#011627 guifg=#93aaaa
" - Tone down whitespace (and vim mappings)
hi SpecialKey               guifg=#a8826b
" - Play with diffs
hi diffAdded   guifg=#40dd40
hi diffRemoved guifg=#dd5874
" - Subtle column marker
hi ColorColumn guibg=#011728
" - Add highlight for column, to match cursor line
hi CursorColumn guibg=#112630

" Trying to use Night Owl terminal colours
let g:terminal_ansi_colors = [
      \ g:terminal_color_0,
      \ g:terminal_color_1,
      \ g:terminal_color_2,
      \ g:terminal_color_3,
      \ g:terminal_color_4,
      \ g:terminal_color_5,
      \ g:terminal_color_6,
      \ g:terminal_color_7,
      \ g:terminal_color_8,
      \ 'red',
      \ g:terminal_color_10,
      \ g:terminal_color_11,
      \ g:terminal_color_12,
      \ g:terminal_color_13,
      \ g:terminal_color_14,
      \ g:terminal_color_15
      \]
