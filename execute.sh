#!/bin/bash
source "./scripts/common/loggers.sh"
source "./scripts/common/sys-links.sh"

# Define an array of directories with source and target paths
declare -A SYMLINKS=(
    ["nvim-ghost"]="$HOME/.config/nvim-ghost"
)

# Loop over the array to create symlinks
for dir in "${!SYMLINKS[@]}"; do
    create_symlink_stow "$dir" "${SYMLINKS[$dir]}"
done 