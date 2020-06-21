" Custom Vim config
"
" Most of this is vanilla but it's cobbled together from lots of sources:
" - VimConfig.com
" - https://stevelosh.com/blog/2010/09/coming-home-to-vim/#s11-important-vimrc-lines

" High level
set nocompatible	" Turn of old vi compatibility mode
set modelines=0     	" Disable modelines
set encoding=utf-8	" Just make everything boring

" General
"set number		" Show line numbers
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
set incsearch		" Searches for strings incrementally

set autoindent		" Auto-indent new lines
set shiftwidth=2	" Number of auto-indent spaces
set smartindent		" Enable smart-indent
set smarttab		" Enable smart-tabs
set softtabstop=0	" Number of spaces per Tab

" Advanced
set ruler		" Show row and column ruler information
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

" Enable code folding
set foldmethod=indent
set nofoldenable	" Do not fold on opening
set foldnestmax=10
set foldlevel=1         " Fold second level on opening

" Key bindings
let mapleader = ","	" Change default leader from '\'

" Convenience mappings
" - Deselect highlighting
nnoremap <leader><Space> :nohlsearch<CR>

" General file editing enhancements
syntax on
filetype indent plugin on

" Specific file types
autocmd Filetype gitcommit set textwidth=80

