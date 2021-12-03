#!/bin/bash

# Format markdown-ish table

grep -v -e '---' \
| sed -e 's/|/^|/g' \
| column -s '^' -t \
| sed -e '1p;1s/[^|]/-/g'
