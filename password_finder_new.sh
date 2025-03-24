#!/usr/bin/env bash
TO_FIND="AKIA"

COMMITS=$(git log main -p -S $TO_FIND | grep "commit" | awk '{ print $2 }')
for commit in $COMMITS
do
	FILES=$(git show --pretty="" --name-only $commit)
	for file in $FILE
	do
		git blame $commit $file 
	done
done
