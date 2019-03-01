#!/usr/bin/env bash

set -e

file="$1"

version=$( python3 --version 2>&1 | grep "Python 3.*.*" )
if [[ -z ${version} ]] ; then
    echo "Compiler program needs Python 3.*" >&2
    exit 1
fi

PYTHONPATH=vendor
    python3 vendor/commata "${file}"
echo
