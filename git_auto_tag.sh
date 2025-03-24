#!/usr/bin/env bash
VERSION_FILE=version.txt
DATE=$(date +"%H:%M %d-%m-%y")
HASH_FILE=/tmp/file.txt
if [ ! -f  "$VERSION_FILE" ]; then
	echo "Version file does not exists, creating"
	echo "1" > $VERSION_FILE
fi

version=$(cat "$VERSION_FILE")

while true; do
	git fetch
	CURRENT_HASH=$(git rev-parse HEAD)
 	if [ ! -f "$HASH_FILE" ]; then
  		echo "First run, saving current hash"
  		echo "$CURRENT_HASH" > "$HASH_FILE"
    	fi	
	
        echo "Last Hash $LAST_HASH"
	if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
		echo "New commit with $CURRENT_HASH"
		git pull
		version=$((version + 1))
		version_string="$version $DATE"
		CURRENT_HASH=$(git rev-parse HEAD)
		echo "$version" > "$VERSION_FILE"
		git add "$VERSION_FILE"
        git commit -m "Update version to $version_string"
        git push
	else
		echo "No new commits..."
	fi
 	LAST_HASH=$(cat $HASH_FILE)
	CURRENT_HASH=$(git rev-parse HEAD)
	echo "$CURRENT_HASH" > "$HASH_FILE"
	sleep 3
done

# comment
