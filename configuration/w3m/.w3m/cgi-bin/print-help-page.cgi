#!/usr/bin/env bash

# A CGI script to print the current rendered w3m help page.
#
# ARGUMENTS
#   $QUERY_STRING - string of path to save file to

function W3mHelpScript() {
  local path="$1"

  echo "w3m-control: HELP"
  echo "w3m-control: PRINT $path"
  echo "w3m-control: ABORT"
}

W3mHelpScript "$QUERY_STRING"
