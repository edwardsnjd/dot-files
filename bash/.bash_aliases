# Handy command aliases to make terminal more pleasant

# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'

# Dockerised tools
alias elm='docker run -it --rm -v "$(pwd):/code" -w "/code" -e "HOME=/tmp" -u $UID:$GID -p 8000:8000 codesimple/elm:0.19'

# Date times
alias isodate='date -u +"%Y-%m-%dT%H:%MZ"'

# iTerm2 tmux (control mode and reuse session)
alias tm='tmux -CC new-session -As'

# Web search for given term
function ws {
  local -r search_terms="$@"
  local -r url="https://duckduckgo.com/?q=${search_terms}"
  /Users/nick/bin/brave-cli "${url}"
}

# Watch in colour with configurable interval
function wtch {
  local -r interval="$1"
  local -r args="${@:2}"

  \watch --interval "$interval" --color ~/bin/faketty "$args"
}

# Default is 5 seconds (in colour)
alias watch='wtch 5'

# Github CLI aliases
alias ghw='watch gh'
