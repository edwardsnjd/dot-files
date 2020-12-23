#!/usr/bin/env bash

# Copy config files to home directory
cp -r git/. "$HOME"
cp -r git.windows/. "$HOME"
cp -r bash/. "$HOME"
cp -r vim/. "$HOME"

echo "TODO: Manually copy WindowsTerminal config file"
# TODO: Copy vscode config to target
