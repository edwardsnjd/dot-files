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

# Pick file to edit
alias v='vim $(f)'

# Pick file
alias f='fzf --preview "bat --color=always {}"'

# FZF browse of git diff
function gd {
  preview="git diff --color=always $@ -- {-1}"
  git diff --name-only "$@" | fzf -m --ansi --preview "$preview"
}

# FZF browse of git checkout
function gc {
  preview="git lg -50 {-1}"
  git branch --list --format="%(refname:short)" | fzf --preview "$preview" | xargs git checkout
}

# FZF browse of git log
function glg {
  pretty="format:%C(yellow)%h%C(reset) %s %C(cyan)<%an>%C(red)%d%C(reset)"
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | xargs git show --color | less -c -+F -+X"
  #git lg -n5000 | fzf --ansi --layout=reverse-list --no-sort --preview "$preview"
  git log --graph --color --pretty="$pretty" --date=short | fzf --ansi --layout=reverse-list --no-sort --preview "$preview"
}

# Interactive FZF browse of git log
function gl {
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | xargs git show --color | less -c -+F -+X"
  git lg -n5000 | fzf --ansi --layout=reverse-list --no-sort --bind "enter:execute($preview)"
}
