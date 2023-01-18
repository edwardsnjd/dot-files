#!/usr/bin/env bash

function speed_up_keys() {
  echo "Speed up keys"
  # normal minimum is 15 (225 ms)
  defaults write -g InitialKeyRepeat -int 12
  # normal minimum is 2 (30 ms)
  defaults write -g KeyRepeat -int 2
}

function use_bash() {
  # Default shell is now zsh
  local current_shell=$SHELL
  if [[ $SHELL =~ bash ]]; then
    echo "Already using bash"
  else
    echo "Changing default shell to bash"
    chsh -s /opt/homebrew/bin/bash
  fi
}

speed_up_keys

use_bash

w3m/init.sh

stow --target="${HOME}" \
  alacritty \
  bash \
  bash.osx \
  bat \
  git \
  git.osx \
  tmux \
  vim \
  nvim \
  lf \
  toilet \
  newsboat \
  visidata \
  vis \
  w3m \
  local-bin \
  iterm2 \
  snippets \
  ctags \
  nb \
  zsh \
  subversion \
  readline \
  glow
