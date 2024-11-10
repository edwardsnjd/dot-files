#!/usr/bin/env bash

# Trace bash startup timing
#
# open file descriptor 5 such that anything written to /dev/fd/5
# is piped through ts (pick right command) and then to /tmp/timestamps:
# exec 5> >(/usr/local/bin/ts    -i "%.s" >> /tmp/timestamps)
# exec 5> >(/opt/homebrew/bin/ts -i "%.s" >> /tmp/timestamps)
#
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html:
# export BASH_XTRACEFD="5"
#
# Enable tracing:
# set -x
#
# Analyse timing logs:
# bash-fix-timing /tmp/timestamps

# --- Environment variables ---

# Embrace terminal
export EDITOR=vim
export BROWSER=w3m

# Allow colour
export CLICOLOR=1

# fzf configuration
export FZF_DEFAULT_COMMAND="\
  fd \
    --type file \
    --hidden \
    --color=always \
    --strip-cwd-prefix \
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="\
  fd \
    --type directory \
    --hidden \
    --color=always \
    --max-depth=5 \
"
export FZF_DEFAULT_OPTS="\
  --bind=ctrl-h:preview-down \
  --bind=ctrl-l:preview-up \
  --bind=alt-j:page-down \
  --bind=alt-k:page-up \
  --ansi \
"
export FZF_CTRL_T_OPTS="\
  --preview 'bat --color=always {}' \
  --bind 'ctrl-/:change-preview-window(bottom|hidden|default)' \
"
export FZF_ALT_C_OPTS="\
  --preview 'tree -a -I .git -C --dirsfirst -L 3 {}' \
  --bind 'ctrl-/:change-preview-window(bottom|hidden|default)' \
"

# Use color for man and less
export LESS="\
  --quit-if-one-screen \
  --RAW-CONTROL-CHARS \
  --incsearch \
  --ignore-case \
  --use-color \
  --line-num-width=3 \
  --color=NK-$ \
  --color=SwK$ \
  --color=WwK$ \
"
# Use bold green for bold in less
export LESS_TERMCAP_md=$(tput bold; tput setaf 3)

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Use custom pager (but not really)
export PAGER="pager"

# Specify command lines that should not appear in `history`
export HISTIGNORE="$(cat <<-EOF | tr '\n' ':' | rev | tail -c +2 | rev
		history
		clear:c
		ls:l:ll
		tree:t:tt
		exa
		cd:cd -:cd ..:..:...
		pwd
		git status:git st:g
		exit
		date
		* --help
	EOF
)"
export HISTCONTROL="ignorespace"

# Remember all history and write it all to the history file
export HISTSIZE=-1
export HISTFILESIZE=-1

# Include timestamp on history entries, and display in this format
# YYYY-MM-DDTHH:MM (see strftime)
export HISTTIMEFORMAT="$(tput setaf 5)%F$(tput sgr0)T$(tput setaf 4)%H:%M$(tput sgr0) "

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
export HISTFILE="${XDG_STATE_HOME}/bash/history-$(date +"%Y-%m")"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis/rediscli_history"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"

# Use XDG directories
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# --- Manage PATH ---

# Include homebrew binaries if present
export HOMEBREW_PREFIX="/usr/local"
[ -d "/opt/homebrew" ] && export HOMEBREW_PREFIX="/opt/homebrew"
[ -d "/home/linuxbrew/.linuxbrew" ] && export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
[ -d "$HOMEBREW_PREFIX" ] && eval "$("${HOMEBREW_PREFIX}/bin/brew" shellenv)"

# Include private bin if it exists
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Include private bin if it exists
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# --- Source other files ---

# Include local config if available
[ -f "$HOME/.bash_profile_local" ] && source "$HOME/.bash_profile_local"

# Include rest of things used for all interactive shell
[ -f ~/.bashrc ] && source ~/.bashrc
