#!/bin/bash

print_header() {
    local color='\033[0;32m' # Green color
    local nc='\033[0m'      # No Color
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo ""
    echo -e "${color}==== $1 [$timestamp] ====${nc}"
    echo ""
}

print_subheader() {
    local color='\033[0;32m' # Green color
    local nc='\033[0m'      # No Color
    echo -e "${color}$1${nc}"
    echo ""
}

# Store all the install logs in file
LOG_FILE="install_log.txt"
# Remove existing log file
rm -f "$LOG_FILE"
# Start logging
exec > >(tee -a "$LOG_FILE") 2>&1

# Install System Workflow Apps
print_header "Installing System Workflow Apps"
sudo pacman -S neovim alacritty kitty polybar i3 rofi fish neofetch picom ranger htop lazygit zsh starship tmux firefox

# Install Development Related Packages
print_header "Installing Development Tools"
sudo pacman -S git github-cli fzf ripgrep python nodejs npm pnpm gcc xclip
yay -S google-chrome-stable visual-studio-code-bin

# Install Other Useful Apps
print_header "Installing Other Useful Apps"
yay -S spotify brave-bin

# Install Patched nerd fonts
print_header "Installing Patched Fonts"
yay -S ttf-jetbrains-mono-nerd

print_header "Installing Tmux Plugin Manager"
# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

print_header "Installing Packages Completed."
print_header "Setting up a few things, for you please wait."

print_header"Changing the default shell to zsh."
current_shell=$(basename "$SHELL")

if [ "$current_shell" = "zsh" ]; then
    print_subheader "Zsh is already the default shell."
else
    print_subheader "\nChanging default shell to Zsh..."
    chsh -s "$(which zsh)"
    print_subheader "Default shell changed to Zsh."
fi

print_header "Linking your dotfiles..."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOT_FOLDERS="alacritty,zsh,tmux,kitty,nvim,nvim-alt,nvim-minimal,nvim-old,nvchad"

for folder in $(echo $DOT_FOLDERS | sed "s/,/ /g"); do
    print_subheader "[+] Folder :: $folder"
    stow --ignore=README.md --ignore=LICENSE \
        -t $HOME -D $folder
    stow -v -t $HOME $folder
    print_subheader "Symlinked: $folder"
done

print_subheader "Dotfiles installation complete."
print_subheader "Note:Tmux Plugin Manager - Please press Prefix + I to fetch all the plugins"
print_subheader "[+] Reloading shell..."
# Stop logging before reloading the shell
exec > /dev/tty 2>&1
exec $SHELL -l
# Fin.
