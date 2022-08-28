#!/usr/bin/env bash

# Preview selected file or directory in lf

function main() {
  if [ -d "$1" ]; then
    preview_directory "$@"
  else
    preview_file "$@"
  fi
}

function preview_directory() {
  # NB. Override LESS so less always requires `q` to quit
  tree -aF -I .git --dirsfirst -C -L 5 "$1" \
    | LESS="" less --RAW-CONTROL-CHARS --tilde +g
}

function preview_file() {
  case ${1,,} in
    *.png|*.gif|*.jpg|*.jpeg|*.mov|*.mp4|*.3gp)
      preview_visual "$@";;
    *)
      preview_textual "$@";;
  esac
}

function preview_visual() {
  chafa \
    --animate=false \
    --duration=0 \
    --work=1 \
    --size "${2:-$COLUMNS}x${3:-$LINES}" \
    "$1"
}

function preview_textual() {
  # NB. Override LESS so less always requires `q` to quit
  LESS="" \
  bat \
    --color=always \
    --pager="less --RAW-CONTROL-CHARS --tilde +g" \
    "$1"
}

main "$@"
