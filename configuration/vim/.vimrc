" High level
set nocompatible        " Turn of old vi compatibility mode
set modelines=0         " Disable modelines
set encoding=utf-8      " Just make everything boring

" Buffers
set hidden              " Allow unsaved buffers off screen

" General
set showcmd             " Show commands as typing them
set number              " Show line numbers
set relativenumber      " Show relative line numbers
set linebreak           " Break lines at word (requires Wrap lines)
set showbreak=+++       " Wrap-broken line prefix
set textwidth=0         " Do not change buffer text when wrapping
set showmatch           " Highlight matching brace
set visualbell          " Use visual bell (no beeping)
set cursorline          " Highlight current line
set title               " Set window title if possible

set hlsearch            " Highlight all search results
set smartcase           " Enable smart-case search
set ignorecase          " Always case-insensitive

" Tabs
set tabstop=2           " Size of tab in spaces
set shiftwidth=2        " Number of auto-indent spaces
set expandtab           " Insert spaces for tab key
set smartindent         " Enable smart-indent
set softtabstop=0       " Number of spaces per Tab

" Whitespace
set list                " Display whitespace
set listchars=tab:▸\ ,eol:¬,trail:.

" Advanced
set undolevels=1000     " Number of undo levels

" Enable code folding
set foldmethod=indent
set nofoldenable        " Do not fold on opening
set foldnestmax=10
set foldlevel=1         " Start folding at second level
set foldminlines=0      " Fold single line regions

" Splits in more natural location
set splitbelow
set splitright

" Terminal menus
source $VIMRUNTIME/menu.vim
set wildmenu
set wildcharm=<C-Z>
map <F4> :emenu <C-Z>

" Key bindings
let mapleader = " "     " Change default leader from '\'

" Normal mode mappings:

" - Make copy consistent with other actions
nnoremap Y y$

" - Highlight word under cursor but don't jump
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>

" - Highlight selected text but don't jump
" NOTE: Uses x register
vnoremap <silent> * "xy:<C-U>let @/ = @x <bar> set hls <cr>

" - Resize current window with arrow keys
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Normal mode leader mappings:

" - Save buffer
nnoremap <leader>w :w<CR>

" - Close window
nnoremap <leader>x :close<CR>

" - Close buffer
nnoremap <leader>D :bd<CR>

" - Close buffer but keep window
nnoremap <leader>d :bp \| bd#<CR>

" - Cycle through buffers
nnoremap <leader>j :bn<CR>
nnoremap <leader>k :bp<CR>

" - Run the default build command
nnoremap <leader>b :Make<CR>

" - Fuzzy file search in project
nnoremap <leader>p :Files<CR>

" - Fuzzy file search open buffers
nnoremap <leader>P :Buffers<CR>

" - Fuzzy text search in buffer (in order)
nnoremap <leader>/ :BSLines<CR>

" - Fuzzy tag search in buffer
nnoremap <leader>? :BTags<CR>

" - Fuzzy text search in project
nnoremap <leader>f :RG<CR>

" - Fuzzy text search in project for word under cursor
" NOTE: <C-R><C-W> will not type text that's already there, which will match the
" "b" from the leading "\b"!
nnoremap <leader>F :RG \b<C-R>=expand('<cword>')<CR>\b<CR>

" - Fuzzy text search in project for selected text
" NOTE: Uses x register
vnoremap <leader>F "xy:<C-U>RG <C-R>=escape(getreg('x'), '\()[]+*{}^$')<CR><CR>

" - Display spec outline
nnoremap <leader>so :Redir global /\v\C<(describe\\|context\\|it) /<CR>

" - Display file git history
nnoremap <leader>sg :Redir !git log --oneline -n 1000 -- %<CR>

" - Display file git blame
nnoremap <leader>sb :!git blame -- %<CR>

" - Search devdocs for word under cursor
nnoremap <leader>sd :SearchDevDocs <C-R>=expand('<cword>')<CR><CR>

" - Search devdocs for selected text
" NOTE: Uses x register
vnoremap <leader>sd "xy:<C-U>SearchDevDocs <C-R>=getreg('x')<CR><CR>

" - Copy things about current buffer to clipboard
nnoremap <leader>cf :let @+ = expand("%") <BAR> redraw <BAR> echo 'Copied path to clipboard'<CR>

" - Open in Github
nnoremap <leader>- :GetCurrentBranchLink<CR>

" - Preview markdown
nnoremap <leader>m :PreviewMarkdown<CR><CR>

" - Manually manage location list
nmap <leader>rl <Plug>(LociAdd)
nmap <leader>rc <Plug>(LociClear)

" - Hide chrome (restart to undo)
nnoremap <F5> :set ruler! laststatus=1 showcmd! relativenumber! number! showmode! hidden!<CR>

" - Show highlight groups at the cursor
" See: https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
nmap <silent> <F10> :echo 
\ 'hi<'    . synIDattr(synID(line("."),col("."),1),"name") . '> ' .
\ 'trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> ' .
\ 'lo<'    . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . '>'<CR>

" Show current syntax
noremap <leader>ss :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Fix syntax highlighting it goes wonky
nnoremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" .vimrc shortcuts
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC <BAR> redraw <BAR> echo 'Reloaded .vimrc'<CR>

" Github cli shortcuts
nnoremap <leader>gp :! gh pr create<CR>
nnoremap <leader>gs :! gh pr status<CR>
nnoremap <leader>gc :! gh pr checks<CR>

" Insert mode mappings:

" - Save some LH typing
inoremap jk <Esc>

" - Find and select next placeholder
nnoremap <C-j> :keeppattern normal! /<++><C-v><CR><CR>vf><C-g>
smap <C-j> <Esc><C-j>
imap <C-j> <Esc><C-j>

" - Latex for maths
iabbrev LB <C-G>u$$<CR><++><CR>$$<++>
iabbrev LI <C-G>u$<++>$<++>
iabbrev LF <C-G>u\frac{<++>}{<++>}<++>
iabbrev LS <C-G>u\sum_{<++>}^{<++>}<++>
iabbrev LT <C-G>u\theta_{<++>}^{<++>}<++>
iabbrev LX <C-G>ux_{<++>}^{<++>}<++>
iabbrev LP <C-G>u\frac{\partial <++>}{\partial <++>}<++>
iabbrev LA <C-G>u\begin{array}{rl}<CR><++><CR>\end{array}<++>

" fzf mappings:

" - Display mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" - Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)

" General file editing enhancements
filetype indent plugin on

" Specific file types
autocmd Filetype gitcommit setlocal textwidth=80
autocmd Filetype ruby setlocal colorcolumn=91
autocmd Filetype javascript setlocal colorcolumn=91

" Markdown
autocmd Filetype markdown noremap j gj
autocmd Filetype markdown noremap k gk
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Prefer ripgrep over grep if available
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --glob\ '!/.git/'
endif

" New commands

" Improve :Rg command to include hidden files
command! -bang -nargs=* RG call fzf#vim#grep(
\ "rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!/.git/' -- ".shellescape(<q-args>),
\ 1, fzf#vim#with_preview({'options': ['--exact']}), <bang>0)

" Alternate :BLines command with all lines in order
command! -bang -nargs=* BSLines call fzf#vim#buffer_lines({ 'options': ['--no-sort'] }, <bang>0)

" Preview markdown (OSX using pandoc)
command PreviewMarkdown ! NE_MD_OUT_FILE="${TMPDIR}%:t.html" && pandoc -s --mathjax "%" > "$NE_MD_OUT_FILE" && open "$NE_MD_OUT_FILE"

command! -nargs=* SearchDevDocs silent exec "!open https://devdocs.io/\\#q=".shellescape(<q-args>) | redraw!

" Manually remembering list of locations

nnoremap <Plug>(LociAdd) :laddexpr GetLocation()<CR>
nnoremap <Plug>(LociClear) :lexpr [] <bar> lclose<CR>

function! GetLocation()
  return [GetLocationInfo(), getline('.')]
endfunction

function! GetLocationInfo()
  return expand('%') . ':' . line('.') . ':' . col('.') . ':' . input('Label (optional): ')
endfunction

" Redirect the output of a Vim or external command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor

  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
      \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
      \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif

  vnew

  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" Fix gx URL behaviour until fixed
" See: https://github.com/vim/vim/issues/4738#issuecomment-714609892
if has('macunix')
  function! <SID>OpenURLUnderCursor()
    let s:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;()]*')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction

  nnoremap gx :call <SID>OpenURLUnderCursor()<CR>
endif

" Plugins (managed by `vim-plugin`)
" See `README.md` for bootstrap

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/chrisbra/matchit'
Plug 'https://github.com/tpope/vim-sensible'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-surround'
" Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-projectionist'
Plug 'https://github.com/tpope/vim-dispatch'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/haishanh/night-owl.vim'
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/knsh14/vim-github-link'
Plug 'https://github.com/junegunn/goyo.vim'
Plug 'https://github.com/junegunn/limelight.vim'
call plug#end()

" enable 24bit true color
if (has("termguicolors"))
  set termguicolors
endif

" Expect terminal emulator to display things quickly
if (has("termguicolors"))
  set ttyfast
endif

" Correct italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" enable the theme
colorscheme night-owl
let g:airline_theme='night_owl'

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

" Make netrw (file explorer) look sane
let g:netrw_liststyle = 3     " Nested view
let g:netrw_banner = 0        " No banner
let g:netrw_winsize = 20      " 20% width
