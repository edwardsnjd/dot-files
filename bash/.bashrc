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

# RVM: Load *as a function*
# [ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

