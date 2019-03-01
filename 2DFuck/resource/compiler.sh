#!/usr/bin/env bash

set -e

file="$1"
name="temp-${file}"

version=$( python --version 2>&1 | grep "Python 2.*.*" )
if [[ -z ${version} ]] ; then
    echo "Compiler program needs Python 2.*" >&2
    exit 1
fi

python vendor/remove_comments.py < "${file}" > "${name}"
python vendor/2dfuck.py "${name}"
rm -f "${name}"
echo
