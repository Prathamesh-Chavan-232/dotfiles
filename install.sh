#!/bin/bash

# Loggers
# Define colors
RED='\033[0;31m' # Red color
GREEN='\033[0;32m'  # Green color
LIGHT_PURPLE='\e[1;35m' # Light Purple Color
NC='\033[0m' # No Color
print_header() {
    local color=$1
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo ""
    echo -e "${color}==== $2 [$timestamp] ====${NC}"
    echo ""
}
print_log() {
    local color=$1
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo ""
    echo -e "${color}$2                              [$timestamp]${NC}"
}
print_subheader() {
    local color=$1
    echo -e "${color}$2${NC}"
}


# Installer
install_packages() {
    local package_manager="$1"
    shift
    local package_list=("$@")

    case "$package_manager" in
        "pacman")
            install_command="sudo pacman -S --noconfirm"
            check_command="pacman -Qs"
            ;;
        "yay")
            install_command="yay -S --noconfirm"
            check_command="yay -Qs"
            ;;
        "piaur")
            install_command="piaur -S --noconfirm"
            check_command="piaur -Qs"
            ;;
        "snap")
            install_command="sudo snap install"
            check_command="snap list"
            ;;
        *)
            print_subheader "$RED" "Unsupported package manager: $package_manager"
            exit 1
            ;;
    esac

    for package in "${package_list[@]}"; do
        if $check_command "$package" &> /dev/null; then
            print_subheader "$LIGHT_PURPLE" "$package is already installed."
        else
            $install_command "$package"
            print_log "$GREEN" "$package installed successfully."
        fi
    done
}

# Store all the install logs in file
LOG_FILE="install_log.txt"
# Remove existing log file
rm -f "$LOG_FILE"
# Start logging
exec > >(tee -a "$LOG_FILE") 2>&1

# Install System Workflow Apps
print_header "$GREEN" "Installing System Workflow Apps"
system_packages=("neovim" "alacritty" "kitty" "dunst" "polybar" "i3" "rofi" "neofetch" "picom" "ranger" "htop" "lazygit" "zsh" "starship" "tmux" "firefox" "lsd" "zoxide" "stow")
install_packages "pacman" "${system_packages[@]}"
# sudo pacman -S neovim alacritty kitty dunst polybar i3 rofi neofetch picom ranger htop lazygit zsh starship tmux firefox lsd zoxide

# Install Development Related Packages
print_header  "$GREEN" "Installing Development Tools"
development_tools=("git" "github-cli" "fzf" "ripgrep" "python" "python-pip" "bun" "nodejs" "npm" "pnpm" "gcc" "xclip")
install_packages "pacman" "${development_tools[@]}"
# sudo pacman -S git github-cli fzf ripgrep python python-pip bun nodejs npm pnpm gcc xclip

# Install conda
print_header "$GREEN" "Installing Miniconda"
# Check if Miniconda is already installed
if command miniconda3 &> /dev/null; then
    print_subheader "$LIGHT_PURPLE" "Miniconda is already installed."
else
    # Miniconda not found, install it
    print_log "$GREEN" "Miniconda is not installed. Installing Miniconda..."

    # Download and install Miniconda
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh

    # Add Miniconda to PATH
    export PATH="$HOME/miniconda/bin:$PATH"

    print_log "$GREEN" "Miniconda installed successfully."
fi

print_header "$GREEN" "Installing Code Editors"
code_editors=("visual-studio-code-bin")
install_packages "yay" "${code_editors[@]}"
# yay -S visual-studio-code-bin

print_header "$GREEN" "Installing Web Browsers"
browsers=("google-chrome" "brave-bin")
install_packages "yay" "${browsers[@]}"
# yay -S google-chrome brave-bin

# Install Other Useful Apps
print_header "$GREEN" "Installing Other Useful Apps"
other_apps=("spotify")
install_packages "yay" "${other_apps[@]}"
# yay -S spotify

# Install Patched nerd fonts
print_header "$GREEN" "Installing Patched Fonts"
patched_fonts=("ttf-jetbrains-mono-nerd")
install_packages "yay" "${patched_fonts[@]}"
# yay -S ttf-jetbrains-mono-nerd

print_header "$GREEN" "Installing Tmux Plugin Manager"
tpm_dir="$HOME/.tmux/plugins/tpm"

# Install Tmux Plugin Manager
# Check if TPM directory already exists
if [ -d "$tpm_dir" ] && [ "$(ls -A "$tpm_dir")" ]; then
    print_subheader "$LIGHT_PURPLE" "Tmux Plugin Manager (TPM) is already installed at $tpm_dir."
else
    # TPM directory doesn't exist or is empty, clone the repository
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    print_subheader "$GREEN" "TPM installed successfully at $tpm_dir."
fi
# Install zsh plugin Manager
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
print_subheader "$GREEN" "Zsh Plugin Manager (Zap) installed successfully at $tpm_dir."

print_log "$GREEN" "Installing Packages Completed."
echo ""
print_subheader "$GREEN" "Setting up a few things, for you please wait."

print_header "$GREEN" "Changing the default shell to zsh."
current_shell=$(basename "$SHELL")

if [ "$current_shell" = "zsh" ]; then
    print_subheader "$LIGHT_PURPLE" "Zsh is already the default shell."
else
    print_subheader "$GREEN" "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
    print_log "$GREEN" "Default shell changed to Zsh."
fi
print_header "$GREEN" "Switching to local clock"
timedatectl set-local-rtc 1 --adjust-system-clock

print_header "$GREEN" "Linking your dotfiles..."
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOT_FOLDERS="alacritty,zsh,tmux,kitty,nvim,nvim-alt,nvim-minimal,nvim-old,nvchad"

for folder in $(echo $DOT_FOLDERS | sed "s/,/ /g"); do
    print_log "$GREEN" "[+] File/Folder :: $folder"
    stow --ignore=README.md --ignore=LICENSE \
        -t $HOME -D $folder
    stow -v -t $HOME $folder
    print_subheader "$GREEN" "Symlinked: $folder"
done

print_subheader "$LIGHT_PURPLE" "Note: Tmux Plugin Manager is installed, Please press Prefix + I in a tmux session to load all the plugins"
print_subheader "$LIGHT_PURPLE" "Note: Starship is installed but isn't used"
print_log "$GREEN" "Dotfiles installation complete."
echo ""
echo -n "Do you want to reload the shell? (Y/n):"
read response

# Convert the response to lowercase for case-insensitive comparison
response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ $response_lower == "y" ]]; then
    print_subheader "[+] Reloading shell..."
    exec > /dev/tty 2>&1 # Stop logging to text file before reloading the shell
    exec $SHELL -l
  # Add your code here for the 'yes' case
elif [[ $response_lower == "n" ]]; then
  # Add your code here for the 'no' case
  print_log "$RED" "Please reload the shell to see the changes in effect."
else
  echo "Invalid response. Please enter 'Y/y' or 'N/n'."
fi
# Fin.
