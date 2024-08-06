#!/bin/bash

# Function to create symlinks for a directory
create_symlink_stow() {
    local dir="$1"
    local target_dir="$2"

    if [ ! -d "$target_dir" ]; then
        echo "Target directory $target_dir does not exist. Creating..."
        mkdir -p "$target_dir"
    fi

    # Use stow to create symlinks
    print_log "$GREEN" "[+] Sym-linking Folder :: $dir"
    stow -vt "$target_dir" "$dir"
}
