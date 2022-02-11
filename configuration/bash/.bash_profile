# --- Environment variables ---

# Embrace vim
export EDITOR=vim

# Allow colour
export CLICOLOR=1

# fzf configuration
export FZF_DEFAULT_COMMAND='fd --type file --hidden --color=always --exclude ".git/"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always {}" --bind=ctrl-/:toggle-preview'
export FZF_ALT_C_COMMAND='fd --type directory --hidden --color=always --exclude ".git/" --max-depth=5'
export FZF_ALT_C_OPTS='--preview "tree -a -I .git -C --dirsfirst -L 3 {}"'
export FZF_DEFAULT_OPTS="--bind=ctrl-h:preview-down,ctrl-l:preview-up --ansi"

# Use color for man and less
export LESS="--quit-if-one-screen --RAW-CONTROL-CHARS --no-init"
# Use bold green for bold in less
export LESS_TERMCAP_md=$(tput bold; tput setaf 3)

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Specify command lines that should not appear in `history`
export HISTIGNORE=history:clear

# Include private bin if it exists
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Include private bin if it exists
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Include any local machine things
[ -f ~/.bash_local ] && source ~/.bash_local

# --- Source other files ---

# Include rest of things used for all interactive shell
[ -f ~/.bashrc ] && source ~/.bashrc

# Tone down "other writeable" panic color
export LS_COLORS="${LS_COLORS}:ow=07;36"

# Cargo (added by rustup)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
