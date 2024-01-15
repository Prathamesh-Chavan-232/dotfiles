#!/bin/bash

# Define colors
RED='\033[0;31m' # Red color
GREEN='\033[0;32m'  # Green color
BLUE='\033[0;34m' # Blue Color
NC='\033[0m' # No Color
print_header() {
    local color=$1
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo ""
    echo -e "${color}==== $2 [$timestamp] ====${NC}"
    echo ""
}
print_fin() {
    local color=$1
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo ""
    echo -e "${color}$2                              [$timestamp]${NC}"
    echo ""
}
print_subheader() {
    local color=$1
    echo -e "${color}$2${NC}"
    echo ""
}

# Store all the install logs in file
LOG_FILE="install_log.txt"
# Remove existing log file
rm -f "$LOG_FILE"
# Start logging
exec > >(tee -a "$LOG_FILE") 2>&1

# Install System Workflow Apps
print_header "$GREEN" "Installing System Workflow Apps"
sudo pacman -S neovim alacritty kitty polybar i3 rofi neofetch picom ranger htop lazygit zsh starship tmux firefox lsd zoxide

# Install Development Related Packages
print_header  "$GREEN" "Installing Development Tools"
sudo pacman -S git github-cli fzf ripgrep python python-pip bun nodejs npm pnpm gcc xclip

# Install conda
print_header "$GREEN" "Installing Miniconda"
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

print_header "$GREEN" "Installing VS Code"
yay -S visual-studio-code-bin

print_header "$GREEN" "Installing Web Browsers"
yay -S google-chrome brave-bin

# Install Other Useful Apps
print_header "$GREEN" "Installing Other Useful Apps"
yay -S spotify

# Install Patched nerd fonts
print_header "$GREEN" "Installing Patched Fonts"
yay -S ttf-jetbrains-mono-nerd

print_header "$GREEN" "Installing Tmux Plugin Manager"
# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

print_subheader "$GREEN" "Installing Packages Completed."
print_subheader "$GREEN" "Setting up a few things, for you please wait."

print_header "$GREEN" "Changing the default shell to zsh."
current_shell=$(basename "$SHELL")

if [ "$current_shell" = "zsh" ]; then
    print_subheader "Zsh is already the default shell."
else
    print_subheader "\nChanging default shell to Zsh..."
    chsh -s "$(which zsh)"
    print_subheader "Default shell changed to Zsh."
fi

print_header "$GREEN" "Linking your dotfiles..."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOT_FOLDERS="alacritty,zsh,tmux,kitty,nvim,nvim-alt,nvim-minimal,nvim-old,nvchad"

for folder in $(echo $DOT_FOLDERS | sed "s/,/ /g"); do
    print_subheader "[+] File/Folder :: $folder"
    stow --ignore=README.md --ignore=LICENSE \
        -t $HOME -D $folder
    stow -v -t $HOME $folder
    print_subheader "Symlinked: $folder"
done

print_fin "$GREEN" "Dotfiles installation complete."
print_subheader "$BLUE"" Note:Tmux Plugin Manager - Please press Prefix + I to fetch all the plugins"
print_subheader "$BLUE" "Note:Starship is installed but isn't used"
# Stop logging before reloading the shell
echo "Do you want to reload the shell? (Y/n): "
read response

# Convert the response to lowercase for case-insensitive comparison
response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ $response_lower == "y" ]]; then
    print_subheader "[+] Reloading shell..."
  # Add your code here for the 'yes' case
elif [[ $response_lower == "n" ]]; then
  # Add your code here for the 'no' case
  print_fin "$RED" "Please reload the shell to see the changes in effect."
else
  echo "Invalid response. Please enter 'yes' or 'no'."
fi
exec > /dev/tty 2>&1
exec $SHELL -l
# Fin.
