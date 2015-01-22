#!/bin/bash

# git2csv.sh - Transfer git metadata to csv comma seperated value format
#              (for import to sqlite3 later)
#              Where "metadata" means "the subset of metadata the author 
#              wanted to analyze" :-)

# NOTE: This only works if your repo has no files or folders with spaces.
#       Also, I'm sure there are a lot of other edge case failure modes.
# This project has a far better (and more complex) git-fast-export parser:
# github.com/maxandersen/jbosstools-gitmigration/tree/master/git_fast_filter


export LC_ALL=C

git fast-export --no-data --all > gfe.txt
echo >> gfe.txt

test -f gfe.csv && rm gfe.csv

unset MARK
while read GFE; do
	ITEMS=($GFE)
	if [[ ${ITEMS[0]} == 'M' ]]; then
		printf "$MARK,${ITEMS[2]},${ITEMS[3]}\n" >> gfe.csv
	elif [[ ${ITEMS[0]} == 'mark' && ${ITEMS[1]:0:2} == :[0-9] ]]; then
		MARK="${ITEMS[1]:1}"
		echo "MARK: $MARK"	
	fi
done < gfe.txt
