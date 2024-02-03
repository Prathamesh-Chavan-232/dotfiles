#!/bin/bash

dotfiles_dir="$HOME/keep-coding/falcon-dots"

# List of dotfiles to symlink
dotfiles=("zsh")

for file in "${dotfiles[@]}"; do
    source_path="$dotfiles_dir/$file"
    target_path="$HOME/.$file"

    # Backup existing dotfiles
    if [ -e "$target_path" ] || [ -h "$target_path" ]; then
        mv "$target_path" "$target_path.bak"
        echo "Backed up: .$file"
    fi

    # Create symlinks
    ln -s "$source_path" "$target_path"
    echo "Symlinked: $folder"
done
