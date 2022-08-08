#!/usr/bin/env bash

# Usage: <++> 
#
# <++>

set -o nounset
set -o errexit
set -o pipefail
#set -o xtrace

Main() {
  local foo=<++>
}

Main "$@"
