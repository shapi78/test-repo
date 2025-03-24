#!/usr/bin/env bash

HASH_FILE=~/hashfile.txt
VERSION_FILE=~/versionfile.txt

while true; do
	current_hash=$(git rev-parse HEAD)
	DATE=$(date "+%Y-%m-%d %H:%M:%S")
	if [ -s "$HASH_FILE" ]; then
		last_hash=$(cat "$HASH_FILE")
		if [[ "$current_hash" != "$last_hash" ]]; then
			echo "New commit with ${current_hash}"
			git pull
			current_hash=$(git rev-parse HEAD)
			echo "$DATE" > "$VERSION_FILE"
		fi
	fi
	echo "$current_hash" > "$HASH_FILE"
	sleep 3
done
