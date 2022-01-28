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
for package in $(cat packages.txt)
do
  sudo apt install -y $package
done

# WORKAROUND: Install bat from local binary (to get later version)
#  See: https://github.com/sharkdp/bat/blob/master/README.md#installation
if ! [ -x "$(command -v bat)" ]; then
  curl -L https://github.com/sharkdp/bat/releases/download/v0.19.0/bat_0.19.0_amd64.deb -o bat.deb
  sudo dpkg -i bat.deb
  rm -f bat.deb
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
  curl -LO https://github.com/visidata/deb-vd/raw/master/pool/main/v/visidata/visidata_2.8-1_all.deb
  sudo dpkg -i visidata_*_all.deb
  rm -f visidata_*_all.deb
fi

# WORKAROUND: Install lf from local binary (to avoid building from go source)
if ! [ -x "$(command -v lf)" ]; then
  curl -LO https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
  tar -xzf lf-linux-amd64.tar.gz
  mv lf ~/.local/bin/lf
  rm lf-linux-amd64.tar.gz
fi

# WORKAROUND: Install vim from local submodule source (to get later version)
if ! [ -x "$(command -v vim)" ]; then
  ./install-vim.sh
fi

# WORKAROUND: Install fzf from local submodule source (to get later version)
if ! [ -x "$(command -v fzf)" ]; then
  ./install-fzf.sh
fi

# Install nb script and dependencies via download
if ! [ -x "$(command -v nb)" ]; then
  sudo curl -L https://raw.github.com/xwmx/nb/master/nb -o /usr/local/bin/nb
  sudo chmod +x /usr/local/bin/nb
  sudo nb completions install
  # Not installing nb env because that downgrades bat
fi

# Install ngrok from binary (because snap doesn't work in WSL)
if ! [ -x "$(command -v ngrok)" ]; then
  curl -L https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip --output ngrok.zip
  unzip ngrok.zip
  mv ngrok ~/.local/bin/ngrok
  rm ngrok.zip
fi

# Install go-jira from binary (to avoid building from go source)
if ! [ -x "$(command -v jira)" ]; then
  curl -L https://github.com/go-jira/jira/releases/download/v1.0.27/jira-linux-amd64 --output jira
  mv jira ~/.local/bin/jira
fi

# Install docker
if ! [ -x "$(command -v docker)" ]; then
  sudo apt-get remove docker docker-engine docker.io containerd runc

  sudo apt-get install ca-certificates curl gnupg lsb-release

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
fi
