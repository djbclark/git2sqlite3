#!/bin/bash

# NOTE: This only works if your repo has no files or folders with spaces.
#       Also, I'm sure there are a lot of other edge case failure modes.


sqlite3 -separator ' ' ganalyze2.db 'SELECT ghash, gfile FROM pkgsrc_head660ancestor_view ORDER BY gfile;' > ancestors.txt

cd /Volumes/usb3ssd/Code/+BIGMERGE/main/pkgsrc
export DIFFBASE="/Volumes/usb3ssd/Code/+BIGMERGE/difftree/ancestors"
while read ANCESTORS; do
	ITEMS=($ANCESTORS)
	BASEDIR="$(dirname $DIFFBASE/${ITEMS[1]})"
	[[ -d $BASEDIR ]] || mkdir -p $BASEDIR
	git show ${ITEMS[0]} > $DIFFBASE/${ITEMS[1]}
done < ancestors.txt

