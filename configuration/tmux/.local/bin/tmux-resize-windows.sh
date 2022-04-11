#!/bin/bash

# Bash sanity:

set -o errexit   # abort on nonzero exitstatus
set -o errtrace  # abort on error inside any functions or subshells
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
# set -o xtrace  # turn on traces, useful while debugging

# Functions:

# -- Query --

# current_tmux_window_ids :: () -> String[]
function current_tmux_window_ids() {
  # No session specified means use current session
  # Format is specified to get just the unique window ids
  tmux list-windows -F "#{window_id}"
}

# -- Action --

# resize_windows :: String[] -> ()
function resize_windows() {
  for window_id in $@
  do
    tmux resize-window -t "=${window_id}" -a
  done
}

# Orchestration:

# main :: () -> ()
function main() {
  local window_ids=$(current_tmux_window_ids)
  resize_windows ${window_ids}
}

# Do it!
main
