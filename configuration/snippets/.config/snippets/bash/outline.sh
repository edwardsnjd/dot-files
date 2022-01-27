#!/usr/bin/env bash

# Usage: <++> 
#
# <++>

set -o nounset
set -o errexit

Main() {
  local foo=<++>
}

Main
