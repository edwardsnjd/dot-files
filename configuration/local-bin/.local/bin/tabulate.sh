#!/usr/bin/env bash

sed 's/\t/ | /g' \
| sed '1p;1s/[^|]/-/g'
