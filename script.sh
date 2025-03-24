#!/usr/bin/env bash

HASH_FILE=~/hashfile.txt
VERSION_FILE_NAME="versionfile.txt"
VERSION_FILE=~/${VERSION_FILE_NAME}

while true; do
	current_hash=$(git rev-parse HEAD)
	DATE=$(date "+%Y-%m-%d %H:%M:%S")
	if [ -s "$HASH_FILE" ]; then
		last_hash=$(cat "$HASH_FILE")
		if [[ "$current_hash" != "$last_hash" ]]; then
			echo "New commit with ${current_hash}"
			git pull
			echo "$DATE" > "$VERSION_FILE"
			cp "$VERSION_FILE" "$VERSION_FILE_NAME"
			git add "$VERSION_FILE_NAME"
			git commit -m "Updated ${DATE}"
			git push	
			current_hash=$(git rev-parse HEAD)
		fi
	fi
	echo "$current_hash" > "$HASH_FILE"
	sleep 3
done
