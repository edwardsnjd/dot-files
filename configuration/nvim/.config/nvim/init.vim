set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

" Restore default nvim undo dir
set undodir&

au TextYankPost * silent! lua vim.highlight.on_yank()
