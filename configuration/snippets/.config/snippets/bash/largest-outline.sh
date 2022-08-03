#!/usr/bin/env bash

# NAME
#   <+name+> - <+headline+>
#
# SYNOPSIS
#   <+name+> <command> [options]
#
# DESCRIPTION
#   One of the following commands must be supplied:
#
#   *<+cmd+>*                                     (aliases: <+alias+>)
#      <+desc+>
#         <+name+> <+cmd+> [--<+option+> <<+values+>>] [--] [opts]
#      where:
#         <<+values+>> = <+val+> (default) | <+val+>
#
#   *help*                                       (aliases: -h, --help)
#      Print this usage:
#         <+name+> help
#
# DEPENDENCIES
#   - bash
#   - core utils: awk, cat, echo, printf, sed, sort

set -o nounset
set -o errexit
set -o pipefail
#set -o xtrace

function Main() {
  [[ $# -lt 1 ]] && Error "Missing command"

  local command="$1"
  shift

  case ${command} in
    <+cmd+> | <+alias+>) <+Command+> "$@" ;;
    -h | --help | help) Usage ;;
    *)                  Error "Unknown command: $command" ;;
  esac
}

# Commands

function <+Command+>() {
  local <+option+>=<+def+>
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --<+option+>) shift && <+option+>=$1 ;;
      --)       shift && break ;;
      *)        break ;;
    esac
    shift
  done

  case "$<+option+>" in
    <+def+>) <++> "$@" ;;
    *)   Error "Unknown <+option+>: $<+option+>" ;;
  esac
}

function Usage() {
  sed -E -f <(GetSection "UsageSedScript") $0
}

function Error() {
  echo "ERROR: $@" >&2
  echo >&2
  Usage >&2
  exit 1
}

# Utils

# Get a delimited section of this file
function GetSection() {
  local section="$1"
  sed -En "/^#.*${section}:Start/,/^#.*${section}:End/ { s/^# ?//; p; }" $0 | sed '1d; $d'
}

# Entry point

Main "$@"

exit 0

# NOTE: The rest of this file is not executed, so can hold scripts for
# different languages etc.  Use `GetSection xxx` to obtain the text for a
# particular section.

#~~~~~~~~~~~~~~~~~~~~UsageSedScript:Start~~~~~~~~~~~~~~~~~~~~
# #n
# /^#!/ n
# /^#/ {
#   :heading
#   /^#/ {
#     s/^# ?//
#     p
#     n
#     b heading
#   }
#   q
# }
#~~~~~~~~~~~~~~~~~~~~~UsageSedScript:End~~~~~~~~~~~~~~~~~~~~~
