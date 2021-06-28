#!/bin/bash

# WORKAROUND: Update apt sources for Github CLI tool
#  See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-apt
if ! [ -f "/usr/share/keyrings/githubcli-archive-keyring.gpg" ]; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
fi

# Install APT packages
cat packages.txt | xargs sudo apt install -y

# WORKAROUND: Install bat from local binary (to get later version)
#  See: https://github.com/sharkdp/bat/blob/master/README.md#installation
if ! [ -x "$(command -v bat)" ]; then
  curl -LO https://github.com/sharkdp/bat/releases/download/v0.18.1/bat_0.18.1_amd64.deb
  sudo dpkg -i bat_0.18.1_amd64.deb
  rm -f bat_0.18.1_amd64.deb
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

# WORKAROUND: Install visidata from local binary (to get later version)
if ! [ -x "$(command -v vd)" ]; then
  curl -LO https://github.com/saulpw/deb-vd/raw/master/pool/main/v/visidata/visidata_2.4-1_all.deb
  sudo dpkg -i visidata_*_all.deb
  rm -f visidata_*_all.deb
fi

# WORKAROUND: Install lf from local binary (to avoid building from go source)
if ! [ -x "$(command -v lf)" ]; then
  curl -LO https://github.com/gokcehan/lf/releases/download/r22/lf-linux-arm64.tar.gz
  tar -xzf lf-linux-arm64.tar.gz
  mv lf ~/.local/bin/lf
  rm lf-linux-arm64.tar.gz
fi

# WORKAROUND: Install Android Studio from binary (because snap doesn't work in WSL)
if ! [ -x "$(command -v studio.sh)" ]; then
  curl -LO https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.1.3.0/android-studio-ide-201.7199119-linux.tar.gz
  tar -xzf android-studio-ide-201.7199119-linux.tar.gz
  rm android-studio-ide-201.7199119-linux.tar.gz
  sudo mv android-studio /usr/share
  ln --symbolic /usr/share/android-studio/bin/studio.sh ~/.local/bin/studio.sh
fi

# WORKAROUND: Install vim from local submodule source (to get later version)
if ! [ -x "$(command -v vim)" ]; then
  pushd vim
  make distclean  # if you build Vim before
  make
  sudo make install
  popd
fi

# WORKAROUND: Install fzf from local submodule source (to get later version)
./fzf/install --all
