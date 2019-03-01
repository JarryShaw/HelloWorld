#!/usr/bin/env bash

set -e

file="$1"

# if [ ! -f vendor/3var ] ; then
#     ( cd vendor; make > /dev/null 2>&1 ; )
# fi

vendor/3var "${file}"
echo
