#!/usr/bin/env bash

# Usage: ./install-nb.sh
#
# Install (or update) nb from Github

set -o nounset
set -o errexit

Main() {
  sudo curl -L https://raw.github.com/xwmx/nb/master/nb -o /usr/local/bin/nb
  sudo chmod +x /usr/local/bin/nb
  sudo nb completions install
  # Not installing nb env because that downgrades bat
}

Main
