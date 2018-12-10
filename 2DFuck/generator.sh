#!/usr/bin/env bash

string="$1"

vension=$( python --version 2>&1 | grep "Python 2.*.*" )
if [[ -z ${version} ]] ; then
    echo "Compiler program needs Python 2.*" >&2
    exit 1
fi

echo $( python vendor/strto2dfuck.py "${string}" 2> /dev/null )
