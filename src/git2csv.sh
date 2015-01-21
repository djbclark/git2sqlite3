#!/bin/bash
 
# Note: It would probably be a lot faster to use git fast-export and an edited
# github.com/maxandersen/jbosstools-gitmigration/tree/master/git_fast_filter
# but this was already done...
 
export LC_ALL=C
export COUNT="1"
git log --full-history --pretty=format:"%T" > S.git-log
echo >> S.git-log
test -f S.csv && rm S.csv
while read TREE; do
  git ls-tree --full-tree -r $TREE \
  | fgrep ' blob ' \
  | awk -v C="$COUNT" '{print C","$3","$4}' >> S.csv
  COUNT="$(expr $COUNT + 1)"
done < S.git-log
