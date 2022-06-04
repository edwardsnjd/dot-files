#!/usr/bin/env bash

function speed_up_keys() {
  echo "Speed up keys"
  # normal minimum is 15 (225 ms)
  defaults write -g InitialKeyRepeat -int 12
  # normal minimum is 2 (30 ms)
  defaults write -g KeyRepeat -int 2
}

speed_up_keys

stow --target="${HOME}" \
  alacritty \
  bash \
  bash.osx \
  bat \
  git \
  git.osx \
  tmux \
  vim \
  lf \
  toilet \
  newsboat \
  visidata \
  vis \
  w3m \
  local-bin \
  iterm2 \
  snippets \
  ctags
