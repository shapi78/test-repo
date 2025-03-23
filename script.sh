#!/usr/bin/env bash
VERSION_FILE=version.txt
HASH_FILE=file.txt
version=1
if [ -s "$VERSION_FILE" ]; then
	version=$(cat "$VERSION_FILE")
fi
while true; do
	CURRENT_HASH=$(git rev-parse HEAD)
	LAST_HASH=$(cat file.txt)
	if [[ "$CURRENT_HASH" != "$LAST_HASH" && -s "$HASH_FILE" ]]; then
		echo "New commit happened!"
		TAG="dor-v${version}.0"
		git tag "$TAG" &>/dev/null
		git push origin "$TAG" &> /dev/null
		version=$((version + 1))
		CURRENT_HASH=$(git rev-parse HEAD)
	else
		echo "No new commits..."
	fi
	echo "$CURRENT_HASH" > file.txt
	echo "$version" > "$VERSION_FILE"
	sleep 3
done

