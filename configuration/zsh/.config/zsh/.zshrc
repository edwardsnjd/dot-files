
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

###-tns-completion-start-###
if [ -f /Users/nick/.tnsrc ]; then 
    source /Users/nick/.tnsrc 
fi
###-tns-completion-end-###

# fzf autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /Users/nick/.config/broot/launcher/bash/br
