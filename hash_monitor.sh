#! /bin/bash

repo_path="/home/oleg/Desktop/l_repo/test-repo"
branch="olegb"
version_file="version.txt"
current_date=$(date +"%H:%M %d-%m-%y")
pass_keyword='AK'
blame_file="git-blame.log"

if [ ! -f "$version_file" ]; then
    echo "Version file does not exist, creating..."
    touch $version_file
fi

cd $repo_path

while true; do

	local_commit=$(git rev-parse HEAD)

	git fetch origin

    if [ ! -f "$blame_file" ]; then
        touch "./$blame_file"
    fi

    grep -rlP "$pass_keyword.{0,21}" $(git ls-files) >> $blame_file 

	remote_commit=$(git rev-parse "origin/$branch")

	if [[ $local_commit != $remote_commit ]]; then
		echo "There was a change"
		echo "$current_date" >> "$version_file"
		git add $version_file
		git commit -m "Updated on: $current_date"
		git push origin $branch
		git pull origin $branch --rebase
		#git reset --hard origin/$branch
	else
		echo "nothing changed"
	fi
	sleep 30
done
