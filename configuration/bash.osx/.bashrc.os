# Disable annoying bash shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set browser for CLI tools (custom binstub)
export BROWSER="/Users/nick/bin/chrome-cli"

export ANDROID_HOME=/usr/local/opt/android-sdk

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home

# Bash completion
[ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"

# Graphviz (alias but should be a script)
[ -f ~/.bash_graphviz ] && source ~/.bash_graphviz
