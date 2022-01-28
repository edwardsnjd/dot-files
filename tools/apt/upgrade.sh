#!/bin/bash

# Update list of packages
sudo apt update

# Upgrade all installed packages
sudo apt upgrade

# Upgrade vim
(cd vim && git pull && git commit -m "chore: Bump vim to latest version")
./install-vim.sh

# Upgrade fzf
(cd fzf && git pull && git commit -m "chore: Bump fzf to latest version")
./install-fzf.sh

# Upgrade nb
./install-nb.sh
