#!/usr/bin/env bash

CURRENT_HASH=$(git rev-parse origin/main)
LAST_HASH=$(cat file.txt)
while true; do
	if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
		echo "New commit happened!"
	else
		echo "No new commits..."
	fi
	echo "$CURRENT_HASH" > file.txt
	sleep 3
done

