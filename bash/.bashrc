# --- Bash aliases ---

# Alias definitions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Graphviz (alias but should be a script)
[ -f ~/.bash_graphviz ] && source ~/.bash_graphviz

# Bash completion
[ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"

# Prompt (env)
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

# Appbot config (env)
[ -f ~/.bash_appbot ] && source ~/.bash_appbot

# fzf autocompletion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# NVM
export NVM_DIR="$HOME/.nvm"
[ -f "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
[ -f "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# End NVM
# Note: NVM will not be ready until after it's been called once with `nvm ...`

# RVM: Load *as a function*
# [ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

