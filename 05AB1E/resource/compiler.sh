#!/usr/bin/env bash

set -e

file="$1"

# if [ -z $( which escript ) ] ; then
#     echo "Elixir not installed." >&2
#     exit 1
# fi

# if [ -z $( which mix ) ] ; then
#     echo "Mix not installed." >&2
#     exit 1
# fi

# cd vendor
# mix local.hex
# mix deps.get
# MIX_ENV=prod \
#     mix escript.build

cd ..
escript vendor/osabie "${file}"
echo
