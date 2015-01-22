#!/bin/bash

# git2csv.sh - Transfer git metadata to csv comma seperated value format
#              (for import to sqlite3 later)

# NOTE: This only works if your repo has no files or folders with spaces.


export LC_ALL=C

git fast-export --no-data --all > gfe.txt
echo >> gfe.txt

test -f gfe.csv && rm gfe.csv

unset MARK
while read GFE; do
	ITEMS=($GFE)
	if [[ ${ITEMS[0]} == 'M' ]]; then
		printf "$MARK,${ITEMS[2]},${ITEMS[3]}\n" >> gfe.csv
	elif [[ ${ITEMS[0]} == 'mark' ]]; then
		MARK="${ITEMS[1]:1}"
		echo "MARK: $MARK"	
	fi
done < gfe.txt
