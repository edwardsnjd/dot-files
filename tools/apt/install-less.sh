#!/usr/bin/env bash

# Usage: ./install-less.sh
#
# Install less from source.

Main() {
  curl -L http://www.greenwoodsoftware.com/less/less-608.tar.gz --output less-608.tar.gz
  tar -xf less-608.tar.gz
  (
    cd less-608
    sh configure \
      && make \
      && sudo make install
  )
  rm less-608.tar.gz
  rm -rf less-608
}

Main
