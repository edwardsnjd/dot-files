#!/usr/bin/env bash

# HACK: w3m does not separate its configuration and data directories
# and we use a stub (see configuration/w3m/.local/bin/w3m) to move all
# of them under XDG_CONFIG_HOME.  By ensuring that directory exists we
# make sure that stow does not symlink the entire thing and instead mixes
# in our configuration files alongside the runtime files.
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$XDG_CONFIG_HOME/.w3m"
