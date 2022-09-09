#!/usr/bin/env bash

# --- Bash aliases ---

# Alias definitions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Bash keybindings
[ -f ~/.bash_keys ] && source ~/.bash_keys

# Readline configuration
[ -f ~/.bash_readline ] && source ~/.bash_readline

# Prompt (env)
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

# fzf autocompletion
[ -f ~/.bash_gpg ] && source ~/.bash_gpg

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
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# Allow OS overrides
[ -f ~/.bashrc.os ] && source ~/.bashrc.os

# Cargo (added by rustup)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
