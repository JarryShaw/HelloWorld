#!/usr/bin/env bash

set -e

file="$1"

version=$( python3 --version 2>&1 | grep "Python 3.*.*" )
if [[ -z ${version} ]] ; then
    echo "Compiler program needs Python 3.*" >&2
    exit 1
fi

python3 vendor/gistfile1.py < "${file}"
echo
