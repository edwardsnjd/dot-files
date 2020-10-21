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

" - Highlight word under cursor but don't jump
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>

" - Resize current window with arrow keys
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

" Normal mode leader mappings:

" - Save buffer
nnoremap <leader>w :w<CR>

" - Close buffer
nnoremap <leader>d :bd<CR>

" - Close buffer but keep window
nnoremap <leader>D :bp \| bd#<CR>

" - Cycle through buffers
nnoremap <leader>j :bn<CR>
nnoremap <leader>k :bp<CR>

" - Run the default build command
nnoremap <leader>b :Make<CR>

" - Deselect highlighting
nnoremap <leader>l :nohlsearch<CR>

" - Fuzzy file search in project
nnoremap <leader>p :Files<CR>

" - Fuzzy file search open buffers
nnoremap <leader>P :Buffers<CR>

" - Fuzzy text search in buffer
nnoremap <leader>/ :BLines<CR>

" - Fuzzy text search in buffer (in order)
nnoremap <leader>? :BSLines<CR>

" - Fuzzy text search in project
nnoremap <leader>f :RG<CR>

" - Fuzzy text search in project for word under cursor
nnoremap <leader>F :RG \b<C-R><C-W>\b<CR>

" - Display spec outline
nnoremap <leader>so :Redir global /\v\C<(describe\|context\|it) /<CR>

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
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" .vimrc shortcuts
noremap <leader>ve :edit $MYVIMRC<CR>
noremap <leader>vr :source $MYVIMRC <BAR> redraw <BAR> echo 'Reloaded .vimrc'<CR>

" Github cli shortcuts
noremap <leader>gp :! gh pr create<CR>
noremap <leader>gs :! gh pr status<CR>
noremap <leader>gc :! gh pr checks<CR>

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

" fzf mappings:

" - Display mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" - Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)

" General file editing enhancements
filetype indent plugin on

" Specific file types
autocmd Filetype gitcommit set textwidth=80

" Prefer ripgrep over grep if available
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --glob\ '!/.git/'
endif

" New commands

" Improve :Rg command to include hidden files
command! -bang -nargs=* RG call fzf#vim#grep(
\ "rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!/.git/' -- ".shellescape(<q-args>),
\ 1, fzf#vim#with_preview(), <bang>0)

" Alternate :BLines command with all lines in order
command! -bang -nargs=* BSLines call fzf#vim#buffer_lines({ 'options': ['--no-sort'] }, <bang>0)

" Preview markdown (OSX using pandoc)
command PreviewMarkdown ! NE_MD_OUT_FILE="${TMPDIR}%:t.html" && pandoc -s --mathjax "%" > "$NE_MD_OUT_FILE" && open "$NE_MD_OUT_FILE"

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
function! Redir(cmd) abort
  let output = execute(a:cmd)
  tabnew
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
  call setline(1, split(output, "\n"))
endfunction

command! -nargs=1 Redir silent call Redir(<f-args>)

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
call plug#end()

" enable 24bit true color
if (has("termguicolors"))
  set termguicolors
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
