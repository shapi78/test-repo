#!/bin/bash

REPO_PATH="/home/liron/Desktop/repo/test-repo/test-repo"
BRANCH="liron"

cd "$REPO_PATH" || exit

while true; do

    LOCAL=$(git rev-parse HEAD)

    git fetch origin "$BRANCH"

    REMOTE=$(git rev-parse origin/"$BRANCH")

if [ "$LOCAL" != "$REMOTE" ]; then
        echo "A change was found in the repository...git pull."
        git pull origin "$BRANCH"
	exit 0
else
	echo "change not found"
	exit 0
fi
done
