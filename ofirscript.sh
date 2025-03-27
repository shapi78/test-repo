#/bin/bash

earlyVersion="$1"
lateVersion="$2"

if [ "$#" -ne 3 ]; then
	echo "you must specify three arguments:"
	echo "for example    v1.1.5    v1.2.6   m(for messages) OR f(for files)"
	exit 1
fi

if [[ $3 == "m" ]]; then
	git log --pretty=format:"- %s" "$earlyVersion".."$lateVersion"
fi

if [[ $3 == "f" ]]; then
	git diff --name-only "$earlyVersion" "$lateVersion"
fi
