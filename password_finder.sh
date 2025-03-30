#!/usr/bin/env bash

cd ~/GitRepos/test-repo
git checkout main

TO_FIND="AKIA"

DETAILS=$(git log -p -S "$TO_FIND")

arr=($DETAILS)

COMMIT_ID=${arr[1]}
AUTHOR=${arr[3]}

echo "$COMMIT_ID"
echo "$AUTHOR"

