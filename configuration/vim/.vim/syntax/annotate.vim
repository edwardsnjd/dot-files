" Annotate
" ========
"
" A fictional syntax used for custom highlighting of arbitrary regions of
" text.

" Define syntax regions based on start/end tags
syntax region Annotate_Red         matchgroup=Annotate_Tag concealends start="<r>" end="</r>" contains=ALL
syntax region Annotate_Green       matchgroup=Annotate_Tag concealends start="<g>" end="</g>" contains=ALL
syntax region Annotate_Yellow      matchgroup=Annotate_Tag concealends start="<y>" end="</y>" contains=ALL
syntax region Annotate_Blue        matchgroup=Annotate_Tag concealends start="<b>" end="</b>" contains=ALL
syntax region Annotate_Magenta     matchgroup=Annotate_Tag concealends start="<m>" end="</m>" contains=ALL
syntax region Annotate_Cyan        matchgroup=Annotate_Tag concealends start="<c>" end="</c>" contains=ALL
syntax region Annotate_RedBold     matchgroup=Annotate_Tag concealends start="<R>" end="</R>" contains=ALL
syntax region Annotate_GreenBold   matchgroup=Annotate_Tag concealends start="<G>" end="</G>" contains=ALL
syntax region Annotate_YellowBold  matchgroup=Annotate_Tag concealends start="<Y>" end="</Y>" contains=ALL
syntax region Annotate_BlueBold    matchgroup=Annotate_Tag concealends start="<B>" end="</B>" contains=ALL
syntax region Annotate_MagentaBold matchgroup=Annotate_Tag concealends start="<M>" end="</M>" contains=ALL
syntax region Annotate_CyanBold    matchgroup=Annotate_Tag concealends start="<C>" end="</C>" contains=ALL

" Associated colours with the syntax groups
highlight Annotate_Red         ctermbg=NONE        ctermfg=Red
highlight Annotate_Green       ctermbg=NONE        ctermfg=Green
highlight Annotate_Yellow      ctermbg=NONE        ctermfg=Yellow
highlight Annotate_Blue        ctermbg=NONE        ctermfg=Blue
highlight Annotate_Magenta     ctermbg=NONE        ctermfg=Magenta
highlight Annotate_Cyan        ctermbg=NONE        ctermfg=Cyan
highlight Annotate_RedBold     ctermbg=DarkRed     ctermfg=Black
highlight Annotate_GreenBold   ctermbg=DarkGreen   ctermfg=Black
highlight Annotate_YellowBold  ctermbg=DarkYellow  ctermfg=Black
highlight Annotate_BlueBold    ctermbg=DarkBlue    ctermfg=Black
highlight Annotate_MagentaBold ctermbg=DarkMagenta ctermfg=Black
highlight Annotate_CyanBold    ctermbg=DarkCyan    ctermfg=Black

" Sensible UI for display
set conceallevel=2
set concealcursor=nv
set nocursorline
syntax sync fromstart
set paste

" Highlight visual selection
vnoremap gar c<r><c-r>"</r><Esc>
vnoremap gag c<g><c-r>"</g><Esc>
vnoremap gay c<y><c-r>"</y><Esc>
vnoremap gab c<b><c-r>"</b><Esc>
vnoremap gam c<m><c-r>"</m><Esc>
vnoremap gac c<c><c-r>"</c><Esc>
vnoremap gaR c<R><c-r>"</R><Esc>
vnoremap gaG c<G><c-r>"</G><Esc>
vnoremap gaY c<Y><c-r>"</Y><Esc>
vnoremap gaB c<B><c-r>"</B><Esc>
vnoremap gaM c<M><c-r>"</M><Esc>
vnoremap gaC c<C><c-r>"</C><Esc>

" Clear highights
vnoremap gax :s/\%V<\/\?[rgybmcRGYBMC]>//g<CR>
nnoremap gaX :%s/<\/\?[rgybmcRGYBMC]>//g<CR>
