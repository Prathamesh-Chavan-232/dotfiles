#!/bin/bash
source "./scripts/common/loggers.sh"
source "./scripts/common/sys-links.sh"

# Define the directories to be symlinked
DOT_FOLDERS="nvim nvim-grimm"

# Create symlinks for remaining folders
for folder in $DOT_FOLDERS; do
    create_symlink_stow "$folder" "$HOME/.config/$folder"
done

