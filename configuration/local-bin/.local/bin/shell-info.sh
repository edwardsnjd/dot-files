# Usage: source shell-info.sh
#
# Output invocation information about the current shell.

Main() {
  shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'
  [[ $- == *i* ]] && echo 'Interactive' || echo 'Not interactive'
}

Main
