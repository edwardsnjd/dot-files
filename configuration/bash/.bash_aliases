# Handy command aliases to make terminal more pleasant

# some more ls aliases
alias  l='ls --color=auto -AFl --group-directories-first'
alias ll='ls --color=auto -AFl --group-directories-first'
alias la='ls --color=auto -AF  --group-directories-first'
# Simpler navigation up
alias   ..='cd ..'          # Go up one directory
alias  ...='cd ../..'       # Go up two directories
alias ....='cd ../../..'    # And for good measure
# Simple tree view
alias    t='tree -aF -I .git --dirsfirst -L 1'
alias   tt='tree -aF -I .git --dirsfirst -L 2'
alias  ttt='tree -aF -I .git --dirsfirst -L 3'
alias tree='tree -aF -I .git --dirsfirst'

# Dockerised tools
function elm {
  docker run \
    -it --rm \
    -v "$(pwd):/code" \
    -w "/code" \
    -e "HOME=/tmp" \
    -u $UID:$GID \
    -p 8000:8000 \
    codesimple/elm:0.19 \
    "$@"
}

# Convert asciinema casts
function asciicast2gif {
  docker run --rm -v $PWD:/data asciinema/asciicast2gif "$@"
}

# Date
alias localdate='date +"%Y-%m-%d"'
alias isodate='date -u +"%Y-%m-%d"'
alias isotime='date -u +"%Y-%m-%dT%H:%MZ"'
alias isostamp='date -u +"%Y-%m-%dT%H:%M:%SZ"'

# Simple lap timer (uses `date` to measure duration in seconds)
function laptimer() {
  local total=0
  local number=0

  # Exit on "s"
  local key="?"
  while [[ "$key" != "s" ]]
  do
    # Print help first time, or on "?"
    if [[ "$key" == "?" ]]
    then
      echo "# Commands: s=stop, ?=help, anything else=lap " 1>&2
    fi

    # Wait for a key
    local before=$(date +%s)
    read -n 1 -p "> " key 1>&2
    local after=$(date +%s)
    echo > /dev/stderr

    # Unless help requested, record a lap
    if [[ "$key" != "?" ]]
    then
      local lap=$(( $after - $before ))
      number=$(( $number + 1 ))
      total=$(( $total + $lap ))

      printf "Lap\t$number\t$lap (s)\t$(( $total / $number )) (avg s)\n"
    fi
  done

  echo "# Stopped" 1>&2
  printf "Total\t$number (#)\t$total (s)\t$(( $total / $number )) (avg s)\n"
}

function stopwatch() {
  local start=$(date +%s)

  printf "0 (s)"  # No newline

  while sleep 1
  do
    local now=$(date +%s)
    # NB. '\r' moves cursor to start of line
    printf "\r$(( $now - $start )) (s)"  # No newline
  done

  echo # Add missing newline
}

# iTerm2 tmux (control mode and reuse session)
alias tm='tmux -CC new-session -As'
# Alias for convenient tmux session picker
alias ta='tmux-attach'

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

  \watch --interval "$interval" --color faketty "$args"
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

# FZF browse of time zone and print current time
function tz {
  fd . /usr/share/zoneinfo \
    | sed 's/.*zoneinfo\///' \
    | fzf \
    | xargs -I{} bash -c "printf \"{}: $(TZ={} date)\n\""
}

# Find current public IP address
function publicip {
  curl ifconfig.me && printf "\n"
}

# Find current weather forecast
function wttr {
  curl wttr.in?pF
}

# FZF browse of files for git diff
function gd {
  details="bat {} --pager='less -c -+F -+X'"
  preview="git diff --color=always $@ -- {}"
  git diff --name-only "$@" \
    | fzf -m --preview "$preview" --bind="enter:execute($details)"
}

# FZF browse of branches for git checkout
function gc {
  format="%(color:yellow)%(refname:short)%(color:reset) %(color:red)%(HEAD)%(color:reset) %(upstream:trackshort) %(upstream:short) %(upstream:track)"
  preview="git lg -100 {1}"
  git branch --list --color --format="$format" \
    | fzf --no-sort --layout=reverse-list --ansi --cycle --preview="$preview" --query="$1" \
    | cut -d" " -f1 \
    | xargs git checkout
}

# FZF browse of git log
function glg {
  pretty="format:%C(yellow)%h%C(reset) %s %C(cyan)<%an>%C(red)%d%C(reset)"
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | head -1 | xargs git show --color | less -c -+F -+X"
  git log --graph --color --pretty="$pretty" --date=short --decorate "$@" \
    | fzf --ansi --layout=reverse-list --no-sort --preview="$preview" --bind 'ctrl-/:toggle-preview' \
    | grep -Eo '[a-f0-9]{7,}' | head -1
}

# Interactive FZF browse of git log
function gl {
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | head -1 | xargs git show --color | less -c -+F -+X"
  git lg -n5000 "$@" \
    | fzf --ansi --layout=reverse-list --no-sort --bind="enter:execute($preview)"
}

# Interactive git history of a file (versions)
function gtt {
  pretty="format:%C(yellow)%h%C(reset) %s %C(cyan)<%an>%C(red)%d%C(reset)"
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | head -1 | xargs -I%% git show %%:$1 | bat --style=plain --color=always --file-name=$1"

  sha=$(
    git log --pretty="$pretty" --color -- $1 \
      | fzf --ansi --layout=reverse-list --no-sort --preview="$preview" --bind 'ctrl-/:toggle-preview' \
      | grep -Eo '[a-f0-9]{7,}' | head -1
  )
  git show "$sha:$1" \
    | bat --file-name="$1"
}

# Interactive git history of a file (diffs)
function gtd {
  pretty="format:%C(yellow)%h%C(reset) %s %C(cyan)<%an>%C(red)%d%C(reset)"
  preview="echo {} | grep -Eo '[a-f0-9]{7,}' | head -1 | xargs -I%% git show --color %% -- $1 | less -c -+F -+X"

  sha=$(
    git log --pretty="$pretty" --color -- $1 \
      | fzf --ansi --layout=reverse-list --no-sort --preview="$preview" --bind 'ctrl-/:toggle-preview' \
      | grep -Eo '[a-f0-9]{7,}' | head -1
  )
  git show "$sha:$1" \
    | bat --file-name="$1"
}

# nb shorcuts

# Edit journal entry for today
function nbj {
  local command="edit"
  if [[ $# -gt 0 ]]; then
    command="$1"
  fi

  case "$command" in
    initcontent)
      echo '```'
      emojify-cal cal
      echo '```'
      echo
      return
      ;;
    edit)
      # Default, fall through to main task
      ;;
    *)
      echo "Unknown command: $1" >&2
      return
      ;;
  esac

  local notebook=journal
  local today=$(date +"%Y-%m-%d")
  local path=${today}.md

  # Ensure the notebook exists
  nb notebooks "${notebook}" \
    || nb notebooks add "${notebook}"

  # Add or edit the note
  nb ls "${notebook}:${path}" \
    && nb edit "${notebook}:${path}" \
    || nb add "${notebook}:${path}" \
      --title "${today}" \
      --tags "journal" \
      --content "$(nbj initcontent)"
}

# Add note on topic
function nbt {

  topic="$1"

  nb add --folder "${topic}"
}

# Slow down `cat` with a pause between each line
function slowcat {
  pause=${1:-2}
  while read
  do
    sleep $pause
    echo "$REPLY"
  done
}

# Output a line of some file pausing for some user input before each line
# Pass file to read on fd 3:  demandcat 3<input.txt
function demandcat {
  while read <&3
  do
    echo "$REPLY"
    read
  done
}
