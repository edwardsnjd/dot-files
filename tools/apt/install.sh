#!/bin/bash

# Install APT packages
cat packages.txt | xargs sudo apt install -y

# FIXUP: Alias batcat to bat (old version of apt package)
if ! [ -x "$(command -v bat)" ]; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# FIXUP: Alias fdfind to fd
if ! [ -x "$(command -v fd)" ]; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/fdfind ~/.local/bin/fd
fi

# WORKAROUND: Install ripgrep with flags to override installation bug
#  See: https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517
if ! [ -x "$(command -v rg)" ]; then
  apt download ripgrep
  sudo dpkg --force-overwrite -i ripgrep*.deb
  rm -f ripgrep*.deb
fi

# WORKAROUND: Install fzf from local submodule source (to get later version)
./fzf/install --all
