#!/usr/bin/env python

# Moves all directories with a specified prefix into a subfolder.
# If there are directories e.g. 'Artist - Album' run 
# the script as follows: 'rename_and_move Artist' 
# A folder named 'Artist' will be created containing a subfolder named 'Album'

import sys, os

if len(sys.argv) < 2:
	print "No directory prefix given"
	sys.exit(0)

pref = sys.argv[1] + ' - '
dire = sys.argv[1]

dirs = [d for d in os.listdir(os.curdir) if d.startswith(pref) and os.path.isdir(d)]
dest = os.path.abspath(dire)

if len(dirs) > 0:
	if not os.path.exists(dire):
		os.mkdir(dire)
	for d in dirs:
		ap = os.path.abspath(d)
		dp = dest + '/' + d[len(pref):]
		print "Moving %s to %s" % (ap, dp)
		os.rename(ap,dp)
