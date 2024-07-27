#!/usr/bin/env bash

THEME_URL="https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/night_owl.toml"

THEME_DIR=".config/alacritty/themes"
THEME_PATH="${THEME_DIR}/night_owl.toml"

function Main() {
  mkdir -p "$THEME_DIR"

  # Get latest theme file
  curl "${THEME_URL}" > "${THEME_PATH}"
}

Main "$@"
