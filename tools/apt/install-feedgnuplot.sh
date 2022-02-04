#!/usr/bin/env bash

# Usage: ./install-feedgnuplot.sh
#
# Install feedgnuplot from submodule.

Main() {
  pushd feedgnuplot
  ln --force --symbolic --relative bin/feedgnuplot ~/.local/bin/
  popd
}

Main
