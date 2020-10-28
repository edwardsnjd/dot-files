#!/usr/bin/env bash

function speed_up_keys() {
  echo "Speed up keys"
  # normal minimum is 15 (225 ms)
  defaults write -g InitialKeyRepeat -int 10
  # normal minimum is 2 (30 ms)
  defaults write -g KeyRepeat -int 1
}

function main() {
  echo "Args: $@"
  case $1 in
     "--speed-up-keys") speed_up_keys;;
     *) echo "TODO: Usage";;
  esac
}

main "$@"
