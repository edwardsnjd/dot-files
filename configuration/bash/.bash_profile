# --- Environment variables ---

# Embrace vim
export EDITOR=vim

# Allow colour
export CLICOLOR=1

# fzf configuration
export FZF_DEFAULT_COMMAND='fd --type file --hidden --color=always --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always {}" --bind=ctrl-/:toggle-preview'
export FZF_ALT_C_COMMAND='fd --type directory --hidden --color=always --max-depth=5'
export FZF_ALT_C_OPTS='--preview "tree -a -I .git -C --dirsfirst -L 3 {}"'
export FZF_DEFAULT_OPTS="--bind=ctrl-h:preview-down,ctrl-l:preview-up,alt-j:page-down,alt-k:page-up --ansi"

# Use color for man and less
export LESS="--quit-if-one-screen --RAW-CONTROL-CHARS --no-init --incsearch"
# Use bold green for bold in less
export LESS_TERMCAP_md=$(tput bold; tput setaf 3)

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Specify command lines that should not appear in `history`
export HISTIGNORE=history:clear

# Remember all history and write it all to the history file
export HISTSIZE=-1
export HISTFILESIZE=-1

# Include timestamp on history entries, and display in this format
# YYYY-MM-DDTHH:MM (see strftime)
export HISTTIMEFORMAT="$(tput setaf 5)%F$(tput sgr0)T$(tput setaf 4)%H:%M$(tput sgr0) "

# Include private bin if it exists
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Include private bin if it exists
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Tone down "other writeable" panic color
export LS_COLORS="${LS_COLORS}:ow=07;36"

# XDG base directory spec
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# export XDG_RUNTIME_DIR="/run/user/$UID"  # Readonly fs on MacOS... err...
# Ensure XDG directories exist
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_STATE_HOME}"
# Not making XDG_RUNTIME_DIR

# Move files under XDG directories
export ANDROID_HOME="${XDG_DATA_HOME}/android"
export HISTFILE="${XDG_STATE_HOME}/bash/history-$(date +%F)"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis/rediscli_history"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"

# Use XDG directories
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# --- Source other files ---

# Include any local machine things
[ -f ~/.bash_local ] && source ~/.bash_local

# Include rest of things used for all interactive shell
[ -f ~/.bashrc ] && source ~/.bashrc
