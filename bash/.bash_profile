# --- Environment variables ---

# Allow colour
export CLICOLOR=1

# Disable annoying bash shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# fzf configuration
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- Source other files ---

function source_if_present {
  [ -f "$1" ] && source "$1"
}

# Load the default .profile
source_if_present "$HOME/.profile"

# Bash completion
source_if_present "$(brew --prefix)/etc/bash_completion"

# Alias definitions
source_if_present ~/.bash_aliases

# Prompt
source_if_present ~/.bash_prompt

# Appbot config
source_if_present ~/.bash_appbot

# Graphviz
source_if_present ~/.bash_graphviz

# fzf autocompletion
source_if_present ~/.fzf.bash

# RVM: Load *as a function*
# source_if_present "$HOME/.rvm/scripts/rvm"

# NativeScript
###-tns-completion-start-###
source_if_present ~/.tnsrc
###-tns-completion-end-###

# NVM
export NVM_DIR="$HOME/.nvm"
source_if_present "$NVM_DIR/nvm.sh"
source_if_present "$NVM_DIR/bash_completion"
# End NVM

