#!/usr/bin/env bash

function speed_up_keys() {
  echo "Speed up keys"
  # normal minimum is 15 (225 ms)
  defaults write -g InitialKeyRepeat -int 12
  # normal minimum is 2 (30 ms)
  defaults write -g KeyRepeat -int 2
}

function link_os_bins() {
  local target=~/.local/bin/airport
  if [[ ! -s "$target" ]]; then
    echo "Linking airport to $target"
    ln -s \
      /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport \
      ~/.local/bin/
  else
    echo "(airport already linked)"
  fi
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

link_os_bins

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
  glow \
  emacs \
  kak \
  helix \
  less \
  llm-filter \
  gh \
  wezterm \
  info
