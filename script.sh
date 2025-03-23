#!/usr/bin/env bash
VERSION_FILE=version.txt
if [ -s "$VERSION_FILE" ]; then
	version=$(cat "$VERSION_FILE")
else
	version=1
fi
TAG="dor-v${version}.0"
while true; do
	CURRENT_HASH=$(git rev-parse HEAD)
	LAST_HASH=$(cat file.txt)
	if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
		echo "New commit happened!"
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

