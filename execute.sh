#!/bin/bash
source "./scripts/common/loggers.sh"
source "./scripts/common/sys-links.sh"

# Define an array of directories with source and target paths
declare -A SYMLINKS=(
    ["nvim-ghost"]="$HOME/.config/nvim-ghost"
    ["other-nvims/nvim-code"]="$HOME/.config/nvim-code"
    ["other-nvims/nvim-super"]="$HOME/.config/nvim-super"
    ["other-nvims/nvim-front"]="$HOME/.config/nvim-front"
)

# Loop over the array to create symlinks
for dir in "${!SYMLINKS[@]}"; do
    create_symlink_stow "$dir" "${SYMLINKS[$dir]}"
done
