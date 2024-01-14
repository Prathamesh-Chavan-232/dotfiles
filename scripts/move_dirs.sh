#!/bin/bash

# List of directories to be sorted
declare -a dirs=("dir_1" "dir_2" "dir_3"

)

# Function to move directories
move_dirs() {
    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            mv "$dir" "$1"
            echo "$dir has been moved to $1/"
        else
            echo "$dir does not exist."
        fi
    done
}

# Call function with the target directory as argument
move_dirs target_dir

