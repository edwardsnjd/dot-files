#!/usr/bin/env bash

# Usage:  <subcommand> [options] -- [arguments]
#
# Subcommands:
#    <+ cmd +> [<+ option +>]
#      <+ desc +>

set -o nounset
set -o errexit
set -o pipefail
#set -o xtrace

function Main() {
  [[ $# -lt 1 ]] && Error "Missing command"

  local subcommand="$1"
  shift

  case ${subcommand} in
    <+ cmd +>) Command "$@" ;;
    *) Error "Unknown command: $subcommand" ;;
  esac
}

function Error() {
  echo "ERROR: $@" >&2
  echo >&2
  Usage >&2
  exit 1
}

function Usage() {
  sed -f <(GetSection "UsageSedScript") $0 \
  | sed -E 's/^# ?//'
}

# Get a delimited section of this file
function GetSection() {
  local section="$1"
  sed -En "/^# ${section}:Start/,/^# ${section}:End/ p" $0 \
  | sed '1d; $d'
}

function Command() {
  echo Command
}

Main "$@"

exit 0

# The rest of this file is not executed, so can hold scripts for
# different languages etc.  Use `GetSection xxx` to obtain the
# text for a particular section.

# UsageSedScript:Start
#n
/^#!/ n
/^#/ {
  :heading
  // {
    p
    n
    b heading
  }
  q
}
# UsageSedScript:End
