#!/usr/bin/env bash

[[ "$1" == --blame=* ]] && blame_lines="${1#*=}" && shift || blame_lines=-1


sorted_tags() {
    python3 -c "

from functools import cmp_to_key


def compare_tags(a, b):
    a_parts = a[4:].split('.')
    b_parts = b[4:].split('.')
    
    for index in range(min(len(a_parts), len(b_parts))):
        if int(a_parts[index]) > int(b_parts[index]):
            return -1
        elif int(a_parts[index]) < int(b_parts[index]):
            return 1
    
    return 0


arr = '''$@'''
arr = arr.strip().split('\n')

sorted_arr = sorted(arr, key=cmp_to_key(compare_tags))
print('\n'.join(sorted_arr))
"
}


file_border() {
    local file="$1"
    local i length=${#file}
    local underline="_"
    local overline="‾"  # u+203e
    local top_border="" bottom_border="" spaces=""

    for ((i=0; i<length+4; i++)); do
        top_border+="$underline"
        bottom_border+="$overline"
        spaces+=" "
    done

    echo "                ${top_border}"
    echo "               |${spaces}|"
    echo "               |  $file  |"
    echo "               |${spaces}|"
    echo "                ${bottom_border}"
}


tags_diff_files() {
    echo "$(git diff --name-only $1 $2)"
}


echo_tags_files_difference() {
    echo "              ======== Files Changes ========"

    for file in "$@"; do
        [ "$blame_lines" -ne 0 ] && file_border "$file" || echo "   $file"

        if [ "$blame_lines" -ne 0 ]; then
            echo "              --- Git Blame ---"

            if [ "$blame_lines" -gt 0 ]; then
                git blame "$tag1" -- "$file" | head -n "$blame_lines"
            else
                git blame "$tag1" -- "$file" || git blame "$tag2" -- "$file"
            fi

            echo "------------------------------------------------"
        fi
    done
}


tags=($(sorted_tags "$(git tag | grep "^Rel")"))
echo
echo "Total Release: ${#tags[@]}"
echo

for ((i=0; i<${#tags[@]}-1; i++)); do
    tag1=${tags[$i]}
    tag2=${tags[$i+1]}

    diff_files=$(tags_diff_files "$tag1" "$tag2")

    echo "======================   $tag2 -> $tag1   ========================="
    echo
    if [ -z "$diff_files" ]; then
        echo "No changes from $tag2 to $tag1"
    else
        echo_tags_files_difference $diff_files
    fi
    echo
done
