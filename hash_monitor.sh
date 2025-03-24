#! /bin/bash

repo_path="/home/oleg/Desktop/l_repo/test-repo"
branch="olegb"
version_file="version.txt"
current_date=$(date +"%H:%M %d-%m-%y")

if [ ! -f "$version_file" ]; then
    echo "Version file does not exist, creating..."
    touch $version_file
fi

cd $repo_path

while true; do

	local_commit=$(git rev-parse HEAD)

	git fetch origin

	remote_commit=$(git rev-parse "origin/$branch")

	if [[ $local_commit != $remote_commit ]]; then
		echo "There was a change"
		echo "$current_date" >> "$version_file"
		git add $version_file
		git commit -m "Updated on: $current_date"
		git push -f origin $branch
		git pull origin $branch
		#git reset --hard origin/$branch
	else
		echo "nothing changed"
	fi
	sleep 30
done
