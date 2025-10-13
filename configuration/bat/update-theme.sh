#!/usr/bin/env bash

THEME_URL="https://raw.githubusercontent.com/batpigandme/night-owlish/master/tmTheme/night-owlish.tmTheme"

THEME_DIR=".config/bat/themes"
THEME_PATH="${THEME_DIR}/night-owlish.tmTheme"

function Main() {
  mkdir -p "$THEME_DIR"

  # Get latest theme file
  curl "${THEME_URL}" > "${THEME_PATH}"

  # Patch the theme file
  sed -i '' -E -f "update-theme.sed" "${THEME_PATH}"
}

Main "$@"
