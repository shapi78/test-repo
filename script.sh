#!/usr/bin/env bash
version=1
while true; do
	CURRENT_HASH=$(git rev-parse HEAD)
	LAST_HASH=$(cat file.txt)
	if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
		echo "New commit happened!"
		git tag "$version"
		git push origin "$version"	
		version=$((version + 1))
		CURRENT_HASH=$(git rev-parse HEAD)
	else
		echo "No new commits..."
	fi
	echo "$CURRENT_HASH" > file.txt
	sleep 3
done

