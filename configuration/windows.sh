#!/usr/bin/env bash

# Copy config files to home directory
cp -r git/. "$HOME"
cp -r git.windows/. "$HOME"
cp -r bash/. "$HOME"
cp -r bash.windows/. "$HOME"
cp -r vim/. "$HOME"

# NOTE: Bat config path is set in environment variable
cp -r bat/.config/bat "$HOME"

# Copy bat themes
mkdir -p "$HOME/AppData/Roaming/bat/themes"
cp -r bat/.config/bat/themes/. "$HOME/AppData/Roaming/bat/themes"

echo "TODO: Manually copy WindowsTerminal config file"
# TODO: Copy vscode config to target
