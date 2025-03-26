#!/usr/bin/env bash


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


tags_diff_files() {
    echo "$(git diff --name-only $1 $2)"
}


echo_tags_files_difference() {
    echo "              ======== Files Changes ========"
          
    for file in "$@"; do
        length=${#file}
        overline="‾"  # u+203e
        underline="_"
        spaces=""

        top_border=""
        bottom_border=""
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

        echo "              --- Git Blame ---"

        git blame "$tag1" -- "$file" || git blame "$tag2" -- "$file"

        echo "------------------------------------------------"
    done
}


tags=($(sorted_tags "$(git tag | grep "^Rel")"))

for ((i=0; i<${#tags[@]}-1; i++)); do
    tag1=${tags[$i]}
    tag2=${tags[$i+1]}

    echo "======================   $tag1 -> $tag2   ========================="
    echo
    echo_tags_files_difference $(tags_diff_files $tag1 $tag2)
    echo
done