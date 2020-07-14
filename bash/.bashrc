
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

###-tns-completion-start-###
if [ -f /Users/nick/.tnsrc ]; then 
    source /Users/nick/.tnsrc 
fi
###-tns-completion-end-###

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# End NVM

# fzf autocompletion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
