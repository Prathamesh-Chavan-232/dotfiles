link_dotfiles() {
    print_header "$LIGHT_PURPLE" "Backing up existing config files"
    mv ~/.zshrc ~/.zshrc.bak

    print_header "$GREEN" "Linking your dotfiles..."

    # Create symlinks for zsh
    create_symlinks "zsh" "$HOME"

    # Create symlinks for remaining folders
    DOT_FOLDERS="alacritty nvim nvim-lazy nvim-ghost tmux starship wezterm"
    for folder in $DOT_FOLDERS; do
      create_symlinks "$folder" "$HOME/.config/$folder"
    done
}
