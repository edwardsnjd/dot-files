#!/usr/bin/env bash

# --- Bash aliases ---

# Alias definitions
[ -f $XDG_CONFIG_HOME/bash/bash_aliases ] && source $XDG_CONFIG_HOME/bash/bash_aliases

# Bash keybindings
[ -f $XDG_CONFIG_HOME/bash/bash_keys ] && source $XDG_CONFIG_HOME/bash/bash_keys

# Readline configuration
[ -f $XDG_CONFIG_HOME/bash/bash_readline ] && source $XDG_CONFIG_HOME/bash/bash_readline

# Prompt (env)
[ -f $XDG_CONFIG_HOME/bash/bash_prompt ] && source $XDG_CONFIG_HOME/bash/bash_prompt

# fzf autocompletion
[ -f $XDG_CONFIG_HOME/bash/bash_gpg ] && source $XDG_CONFIG_HOME/bash/bash_gpg

# fzf autocompletion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# bash config
shopt -s autocd     # directory path is treated as a `cd`
shopt -s cdspell    # correct minor errors in directory names for `cd`
shopt -s direxpand  # expand directory names
shopt -s dirspell   # correct minor errors in directory names on expansion

# NVM
export NVM_DIR="$HOME/.nvm"
[ -f "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
[ -f "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# End NVM
# Note: NVM will not be ready until after it's been called once with `nvm ...`

# RVM: Load *as a function*
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Allow broot convenient launch and extra features
[ -f $XDG_CONFIG_HOME/broot/launcher/bash/br ] && source $XDG_CONFIG_HOME/broot/launcher/bash/br

# Allow OS overrides
[ -f $XDG_CONFIG_HOME/bash/bashrc_os ] && source $XDG_CONFIG_HOME/bash/bashrc_os

# Cargo (added by rustup)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
