#!/bin/bash

REPO_PATH="/home/liron/Desktop/repo/test-repo/test-repo"
BRANCH="liron"
DATE=$(date +"%H:%M %d-%m-%y")
VERSION_FILE=version.txt

cd "$REPO_PATH" || exit

while true; do

    LOCAL=$(git rev-parse HEAD)

    git fetch origin "$BRANCH"

    REMOTE=$(git rev-parse origin/"$BRANCH")

if [ "$LOCAL" != "$REMOTE" ]; then
        echo "A change was found in the repository...git pull."
        git pull origin "$BRANCH"
	if [ ! -f "$VERSION_FILE" ]; then
		echo "Last Commit: $DATE" > "$VERSION_FILE"
	else
		echo "Last commit: $DATE" >> "$VERSION_FILE"
	fi
	git add "$VERSION_FILE"
        git commit -m "Auto-update version file: $DATE"
        git push origin "$BRANCH"
else
	echo "change not found"
fi

sleep 60
done
