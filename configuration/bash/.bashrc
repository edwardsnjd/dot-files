#!/usr/bin/env bash

# Exit if not running interactively ($- = all shell options)
case $- in
    *i*) ;;
      *) return;;
esac

# Alias definitions
[ -f $XDG_CONFIG_HOME/bash/bash_aliases ] && source $XDG_CONFIG_HOME/bash/bash_aliases

# Bash keybindings
[ -f $XDG_CONFIG_HOME/bash/bash_keys ] && source $XDG_CONFIG_HOME/bash/bash_keys

# Readline configuration
[ -f $XDG_CONFIG_HOME/bash/bash_readline ] && source $XDG_CONFIG_HOME/bash/bash_readline

# Prompt (env)
[ -f $XDG_CONFIG_HOME/bash/bash_prompt ] && source $XDG_CONFIG_HOME/bash/bash_prompt

# bash config
shopt -s autocd     # directory path is treated as a `cd`
shopt -s cdspell    # correct minor errors in directory names for `cd`
shopt -s direxpand  # expand directory names
shopt -s dirspell   # correct minor errors in directory names on expansion
shopt -s histappend # append to the history file, don't overwrite it
#shopt -s globstar  # expand "**" in pathname
#shopt -s checkwinsize # update LINES and COLUMNS after each command

# Brew bash completion (+ ~150ms)
# See: https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
if type brew &>/dev/null
then
  # PERFORMANCE: Assumes `HOMEBREW_PREFIX` is already set in `.bash_profile`
  # HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi
# End brew bash completion

# fzf autocompletion
if [ -f ~/.fzf.bash ]; then source ~/.fzf.bash
elif command -v fzf >/dev/null 2>&1; then eval "$(fzf --bash)"
fi

# NVM (+ ~100ms)
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[ -f "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
[ -f "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# End NVM
# Note: NVM will not be ready until after it's been called once with `nvm ...`

# RVM: Load *as a function* (cost ~150ms)
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Allow broot convenient launch and extra features
[ -f $XDG_CONFIG_HOME/broot/launcher/bash/br ] && source $XDG_CONFIG_HOME/broot/launcher/bash/br

# Cargo (added by rustup)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Allow OS overrides
[ -f $XDG_CONFIG_HOME/bash/bashrc_os ] && source $XDG_CONFIG_HOME/bash/bashrc_os

# Include any local machine things
[ -f ~/.bash_local ] && source ~/.bash_local
