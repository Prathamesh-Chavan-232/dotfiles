#!/bin/bash

link_dotfiles() {
  print_header "$LIGHT_PURPLE" "Backing up existing config files"
  mv ~/.zshrc ~/.zshrc.bak

  print_header "$GREEN" "Linking your dotfiles..."

  # Create symlink for zsh
  create_symlink "zsh" "$HOME"

  # Create Symlink for vim
  create_symlink "vim" "$HOME"

  # Create symlinks for remaining folders
  DOT_FOLDERS="nvim nvim-code tmux wezterm"
  for folder in $DOT_FOLDERS; do
    create_symlink "$folder" "$HOME/.config/$folder"
  done
}
