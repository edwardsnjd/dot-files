# --- Bash aliases ---

# Alias definitions
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Prompt (env)
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

# fzf autocompletion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# NVM
export NVM_DIR="$HOME/.nvm"
[ -f "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
[ -f "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# End NVM
# Note: NVM will not be ready until after it's been called once with `nvm ...`

# Allow OS overrides
[ -f ~/.bashrc.osx ] && source ~/.bashrc.osx
[ -f ~/.bashrc.ubuntu ] && source ~/.bashrc.ubuntu
