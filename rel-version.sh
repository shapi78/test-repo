#!/usr/bin/env bash
#This script takes the latest 2 version with a specefied tag, and shows all file differences between the versions
#Usage: bash rel-version [path/to/git/repo, default=.] [Tag to look for, default=rel]

CURRENT_DIR=$(pwd)
target_dir=$1
if [ -z $target_dir ]; then
	target_dir=$CURRENT_DIR
fi
cd $target_dir #Move to the git repo directory
if ! git rev-parse --is-inside-work-tree &>/dev/null; then #Check if looking at a git repository
	echo "Not a git repository..."
	exit 1
fi

tag=$2
if [ -z $tag ]; then
	tag="rel"
fi

git fetch --all #Upadate tags and commits from remote
readarray -t RELEASES < <(git tag --sort=-creatordate | grep -i $tag | head -n 2) #Save two latest tags in array

if [ ${#RELEASES[@]} -lt 2 ]; then #Check if there are atleast 2 releases with that tag
	echo "Not enough releases to make a comparison yet, exiting..."
	exit 2
fi
echo "Showing differences between ${RELEASES[1]} and ${RELEASES[0]}..."
LOG_FILE=/tmp/git-rel-versions.log
git diff ${RELEASES[1]}^..${RELEASES[0]} > $LOG_FILE #Show all differences between files and log them
${EDITOR:-vi} $LOG_FILE
git diff --compact-summary ${RELEASES[1]}^..${RELEASES[0]} #Show summary of differences between versions
cd $CURRENT_DIR
