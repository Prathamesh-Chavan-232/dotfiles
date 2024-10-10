#!/bin/bash
source "./scripts/common/loggers.sh"
source "./scripts/common/sys-links.sh"

# Create symlinks for zsh
create_symlink_stow "zsh" "$HOME"

# Define the directories to be symlinked
DOT_FOLDERS="nvim-grim"

# Create symlinks for remaining folders
for folder in $DOT_FOLDERS; do
    create_symlink_stow "$folder" "$HOME/.config/$folder"
done
