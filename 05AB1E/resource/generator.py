#!/usr/bin/env python

import sys

string = ' '.join(sys.argv[1:])
if '"' in string:
    if sys.version_info.major >= 3:
        print("Quotation mark `\"' will be removed.", file=sys.stderr)
    else:
        print >> sys.stderr, "Quotation mark `\"' will be removed."
program = '"%s"' % string.replace('"', '')

print(program)
