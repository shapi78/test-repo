#!/bin/bash

PATTERN='AK[a-zA-Z0-9]{21}'

git rev-list --all | while read commit; do

    git show --name-only --pretty=format: $commit | while read file; do

        matches=$(git show $commit:$file 2>/dev/null | grep -E "$PATTERN")

        if [[ -n "$matches" ]]; then
            echo "⚠️  Found possible password in file $file at commit $commit:"
            echo "$matches"
            echo "-------------------------------------------"


        fi
    done
done
