#!/bin/bash

# Update list of packages
sudo apt update

# Upgrade all installed packages
sudo apt upgrade

# Upgrade vim
(cd vim && git pull)
git add vim && git commit -em "chore: Bump vim to latest version"
./install-vim.sh

# Upgrade fzf
(cd fzf && git pull)
git add fzf && git commit -em "chore: Bump fzf to latest version"
./install-fzf.sh

# Upgrade nb
./install-nb.sh

# Upgrade feedgnuplot
(cd feedgnuplot && git pull)
git add feedgnuplot && git commit -em "chore: Bump feedgnuplot to latest version"
./install-feedgnuplot.sh
