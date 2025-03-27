#/bin/bash

earlyVersion="$1"
lateVersion=$(git tag | tail -1)

if [ "$#" -ne 2 ]; then
	echo "you must specify three arguments:"
	echo "for example    v1.1.5   m(for messages) OR f(for files)"
	exit 1
fi

if [[ $2 == "m" ]]; then
	git log --pretty=format:"- %s" "$earlyVersion".."$lateVersion"
fi

if [[ $2 == "f" ]]; then
	git diff --name-only "$earlyVersion" "$lateVersion"
fi
