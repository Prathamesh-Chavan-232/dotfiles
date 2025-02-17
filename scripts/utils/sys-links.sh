#!/bin/bash
source "loggers.sh"

# Function to create symlinks for a directory
create_symlink_stow() {
    local dir="$1"
    local target_dir="$2"

    # Check if the target directory exists; create if not
    if [ ! -d "$target_dir" ]; then
        echo "Target directory $target_dir does not exist. Creating..."
        mkdir -p "$target_dir"
    fi

    # Navigate to the directory containing `dir`
    local base_dir
    base_dir=$(dirname "$dir")
    local package_name
    package_name=$(basename "$dir")

    # Use stow to create symlinks from within the base directory
    print_log "$GREEN" "[+] Sym-linking Folder :: $dir -> $target_dir"
    (cd "$base_dir" && stow -vt "$target_dir" "$package_name")
}
