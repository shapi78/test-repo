#! /bin/bash

main_prefix="Oleg_Rel_"

last_tag=$(git describe --tags --match "$main_prefix*" --abbrev=0)

git diff --name-only "$last_tag..HEAD"

version_substring=${last_tag#"$main_prefix"}

patch_number=$(echo $version_substring | awk -F '.' '{print $2}')

if [[ $((patch_number + 1)) -gt 9 ]]; then
    patch_number=$(echo $version_substring | awk -F '.' '{print $1}')
    patch_number=$( $patch_number + 1 )
    git tag "$main_prefix$patch_number.0"
else
    version_substring=${version_substring::-1}
    patch_number=$(( patch_number + 1 ))
    git tag "$main_prefix$version_substring$patch_number"
fi