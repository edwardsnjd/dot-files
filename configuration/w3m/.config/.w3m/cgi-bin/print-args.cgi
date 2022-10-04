#!/usr/bin/env bash

# A CGI script to print the supplied args as a demo
#
# ARGUMENTS
#   $QUERY_STRING - anything you'd like to pass to the script
#
# EXAMPLE
#   $ w3m -dump 'file:/cgi-bin/print-args.cgi?foo=bar&baz'
#   Supplied query string:
#   foo=bar&baz

function W3mDemoCgi() {
  local qs="$1"

  echo
  echo "Supplied query string:"
  echo "$qs"
}

W3mDemoCgi "$QUERY_STRING"
