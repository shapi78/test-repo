#!/usr/bin/env bash

cd ~/GitRepos/test-repo
git checkout main

TO_FIND="AKIA"

DETAILS=$(git log -p -S "$TO_FIND" | grep "commit" | awk '{ print $2 }')

echo "$DETAILS"
