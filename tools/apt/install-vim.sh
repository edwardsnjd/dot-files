#!/usr/bin/env bash

# Usage: ./install-vim.sh
#
# Build and (re)install Vim from submodule.

set -o nounset
set -o errexit

Main() {
  pushd vim
  make distclean  # if you build Vim before
  ./configure --enable-python3interp --with-python3-command=$(which python3)
  make --jobs=8   # Speed up build
  sudo make install
  popd
}

Main
