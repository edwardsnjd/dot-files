# Handy command aliases to make terminal more pleasant

# some more ls aliases
alias l='ls -AlF --group-directories-first'
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

# Print unique lines in the order they appear
# See: https://stackoverflow.com/a/60688574
function dedup {
  awk '!count[$0]++'
}

# Pick file to edit
function v {
  vim $(f "$@")
}

# Pick file to view
function b {
  bat $(f "$@")
}

# Pick file
function f {
  local -r query="$1"

  fzf --preview 'bat --color=always {}' --query "${query}"
}

# Simple tree view
alias t='tree -a -I .git -L 2 --dirsfirst'

# FZF browse of files for git diff
function gd {
  preview="git diff --color=always $@ -- {}"
  git diff --name-only "$@" \
    | fzf -m --preview "$preview"
}

# FZF browse of branches for git checkout
function gc {
  format="%(color:yellow)%(refname:short)%(color:reset) %(color:red)%(HEAD)%(color:reset) %(upstream:trackshort) %(upstream:short) %(upstream:track)"
  preview="git lg -100 {1}"
  git branch --list --color --format="$format" \
    | fzf --no-sort --layout=reverse-list --ansi --cycle --preview="$preview" \
    | cut -d" " -f1 \
    | xargs git checkout
}

# FZF browse of git log
function glg {
  pretty="format:%C(yellow)%h%C(reset) %s %C(cyan)<%an>%C(red)%d%C(reset)"
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | xargs git show --color | less -c -+F -+X"
  git log --graph --color --pretty="$pretty" --date=short --decorate "$@" \
    | fzf --ansi --layout=reverse-list --no-sort --preview="$preview" \
    | grep -Eo '[a-f0-9]{7,}'
}

# Interactive FZF browse of git log
function gl {
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | xargs git show --color | less -c -+F -+X"
  git lg -n5000 "$@" \
    | fzf --ansi --layout=reverse-list --no-sort --bind="enter:execute($preview)"
}

# Git info

function git_commits {
  git log --date=short --pretty="tformat:%h	%ad	%an"
}

function git_stats {
  while read -r sha
  do
    git show --pretty=oneline --numstat $sha \
      | sed '1d' \
      | grep -v '^$' \
      | sed 's/\-/0/g' \
      | datamash count 1 sum 1 sum 2 \
      | awk -v OFS='\t' '{print} END { if (NR == 0) print 0, 0, 0 }'
  done
}

function git_repo_stats {
  paste <(git_commits) <(git_commits | cut -f1 | git_stats)
}
