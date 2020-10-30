# --- Environment variables ---

# Embrace vim
export EDITOR=vim

# Allow colour
export CLICOLOR=1

# Disable annoying bash shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# fzf configuration
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind=ctrl-h:preview-down,ctrl-l:preview-up"

# Set browser for CLI tools (custom binstub)
export BROWSER="/Users/nick/bin/chrome-cli"

# Use color for man and less
export LESS="--quit-if-one-screen --RAW-CONTROL-CHARS --no-init"
# Use bold green for bold in less
export LESS_TERMCAP_md=$(tput bold; tput setaf 3)

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

export ANDROID_HOME=/usr/local/opt/android-sdk

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home

# Specify command lines that should not appear in `history`
export HISTIGNORE=history:clear

# Unused?
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# --- Source other files ---

# Include rest of things used for all interactive shell
[ -f ~/.bashrc ] && source ~/.bashrc
