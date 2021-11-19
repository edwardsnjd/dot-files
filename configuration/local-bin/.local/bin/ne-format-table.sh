#!/bin/bash

# Format markdown-ish table

grep -v -e '---' \
| sed -e 's/|/_|/g' \
| column -s '_' -t \
| sed -e '1p;1s/[^|]/-/g'
