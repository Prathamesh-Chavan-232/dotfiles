link_dotfiles() {
    print_header "$LIGHT_PURPLE" "Backing up existing config files"
    mv ~/.zshrc ~/.zshrc.bak

    print_header "$GREEN" "Linking your dotfiles..."

    # Create symlinks for zsh
    create_symlink "zsh" "$HOME"

    # Create symlinks for remaining folders
    DOT_FOLDERS="nvim"
    for folder in $DOT_FOLDERS; do
      create_symlink "$folder" "$HOME/.config/$folder"
    done
}
