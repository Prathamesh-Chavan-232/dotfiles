#!/bin/bash

source "./common/loggers.sh"
source "./common/sys-links.sh"


create_symlink_stow "../zsh" "$HOME"

DOT_FOLDERS="tmux starship nvim nvim-lazy nvim-code nvim-ghost"

for folder in $DOT_FOLDERS; do
    create_symlink_stow "../$folder" "$HOME/.config/$folder"
done
