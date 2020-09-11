" High level
set nocompatible	" Turn of old vi compatibility mode
set modelines=0     	" Disable modelines
set encoding=utf-8	" Just make everything boring

" Buffers
set hidden		" Allow unsaved buffers off screen

" General
set showcmd		" Show commands as typing them
set number		" Show line numbers
set relativenumber	" Show relative line numbers
set linebreak		" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch		" Highlight matching brace
set visualbell		" Use visual bell (no beeping)
set cursorline		" Highlight current line

set hlsearch		" Highlight all search results
set smartcase		" Enable smart-case search
set ignorecase		" Always case-insensitive

set shiftwidth=2	" Number of auto-indent spaces
set smartindent		" Enable smart-indent
set softtabstop=0	" Number of spaces per Tab

" Advanced
set undolevels=1000	" Number of undo levels

" Enable code folding
set foldmethod=indent
set foldenable		" Fold on opening
set foldnestmax=10
set foldlevel=1         " Fold second level on opening
set foldminlines=1	" Do not fold single line regions

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

" - Deselect highlighting
nnoremap <leader>l :nohlsearch<CR>

" - Fuzzy file search in project
nnoremap <leader>p :Files<CR>

" - Fuzzy text search in buffer
nnoremap <leader>/ :BLines<CR>

" - Fuzzy text search in buffer (in order)
nnoremap <leader>? :BSLines<CR>

" - Fuzzy text search in project
nnoremap <leader>f :RG<CR>

" - Fuzzy text search in project for word under cursor
nnoremap <leader>F :RG <C-R><C-W><CR>

" - Open in Github
nnoremap <leader>- :GetCurrentBranchLink<CR>

" - Preview markdown
nnoremap <leader>m :PreviewMarkdown<CR><CR>

" - Hide chrome (restart to undo)
nnoremap <F5> :set ruler! laststatus=1 showcmd! relativenumber! number! showmode! hidden!<CR>

" Insert mode mappings:

" - Save some LH typing
inoremap jk <Esc>

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
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" New commands

" Improve :Rg command to include hidden files
command! -bang -nargs=* RG call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/**' --glob '!**/node_modules/**' -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" Alternate :BLines command with all lines in order
command! -bang -nargs=* BSLines call fzf#vim#buffer_lines({ 'options': ['--no-sort'] }, <bang>0)

" Preview markdown (OSX using pandoc)
command PreviewMarkdown ! NE_MD_OUT_FILE="${TMPDIR}%:t.html" && pandoc "%" > "$NE_MD_OUT_FILE" && open "$NE_MD_OUT_FILE"

" Plugins (managed by `vim-plugin`)
" See `README.md` for bootstrap

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'https://github.com/tpope/vim-sensible'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-surround'
" Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-projectionist'
Plug 'https://github.com/tpope/vim-dispatch'
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
" - Tone down the search highlighting
hi IncSearch  guibg=#a3cccc guifg=#607080
hi Search     guibg=#404040 guifg=#d6deeb 
" - Tone down the TODO highlight
hi Todo       guibg=#011627 guifg=#93aaaa
" - Tone down whitespace (and vim mappings)
hi SpecialKey               guifg=#a8826b

" Make netrw (file explorer) look sane
let g:netrw_liststyle = 3 " Nested view
let g:netrw_banner = 0    " No banner
let g:netrw_winsize = 20  " 20% width
