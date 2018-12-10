#!/usr/bin/env python

import sys

string = ' '.join(sys.argv[1:])

print('#!/usr/bin/env osascript')
print('')
print('on run argv')
print('    return "%s"' % string.replace('"', '\\"'))
print('end run')
