set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

au TextYankPost * silent! lua vim.highlight.on_yank()
