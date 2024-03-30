#!/bin/bash

# Loggers
# Define colors
RED='\033[0;31m'        # Red color
GREEN='\033[0;32m'      # Green color
LIGHT_PURPLE='\e[1;35m' # Light Purple Color
NC='\033[0m'            # No Color

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
	"dnf")
		install_command="sudo dnf install -y"
		check_command="dnf list installed"
		;;
	"flatpak")
		install_command="flatpak install -y"
		check_command="flatpak list --app --columns=application"
		;;
	*)
		print_subheader "$RED" "Unsupported package manager: $package_manager"
		exit 1
		;;
	esac

	for package in "${package_list[@]}"; do
		if $check_command | grep -q "^$package\$"; then
			print_subheader "$LIGHT_PURPLE" "$package is already installed."
		else
			$install_command "$package"
			print_log "$GREEN" "$package installed successfully."
		fi
	done
}

# Install Development Related Packages
print_header "$GREEN" "Installing Development Tools"
development_tools=("git" "python3" "python3-pip" "nodejs" "npm" "gcc" "gcc-c++" "make" "cmake" "docker")
install_packages "dnf" "${development_tools[@]}"

# Install Flutter
print_header "$GREEN" "Installing Flutter"
flatpak_packages=("io.flutter.flutter" "com.google.Android.NDK")
install_packages "flatpak" "${flatpak_packages[@]}"

# Install System Workflow Apps
print_header "$GREEN" "Installing System Workflow Apps"
system_packages=("neovim" "alacritty" "kitty" "dunst" "polybar" "i3" "rofi" "neofetch" "picom" "ranger" "feh" "ueberzug" "htop" "lazygit" "zsh" "starship" "bat" "tmux" "firefox" "lsd" "zoxide" "ripgrep" "fzf" "xclip" "dust" "btop")

install_packages "dnf" "${system_packages[@]}"

print_header "$GREEN" "Installing Code Editors"
code_editors=("code" "android-studio")
install_packages "dnf" "${code_editors[@]}"

print_header "$GREEN" "Installing Web Browsers"
browsers=("google-chrome-stable" "brave-browser")
install_packages "dnf" "${browsers[@]}"

# Install Other Useful Apps
print_header "$GREEN" "Installing Other Useful Apps"
other_apps=("spotify-client")
install_packages "dnf" "${other_apps[@]}"

# Install Patched nerd fonts
print_header "$GREEN" "Installing Patched Fonts"
patched_fonts=("google-noto-fonts-nerd" "jetbrains-mono-nerd")
install_packages "dnf" "${patched_fonts[@]}"

# Install Icon Themes
print_header "$GREEN" "Installing Icon Theme"
icons_themes=("numix-icon-theme-circle")
install_packages "dnf" "${icon_themes[@]}"

print_header "$GREEN" "Installing GNOME Extensions Manager and Tweaks"
gnome_extensions=("gnome-extensions-app" "gnome-tweaks")
install_packages "dnf" "${gnome_extensions[@]}"

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
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
print_subheader "$GREEN" "Oh My Zsh installed successfully."

print_log "$GREEN" "Installing Packages Completed."
echo ""
print_subheader "$GREEN" "Setting up a few things, for you please wait."

print_header "$LIGHT_PURPLE" "Backing up existing config files"
mv ~/.zshrc ~/.zshrc.bak

# Creating symlinks
print_header "$GREEN" "Linking your dotfiles..."

# Define the directories to be symlinked
DOT_FOLDERS="alacritty kitty nvim nvim-alt nvim-minimal nvchad tmux"

# Function to create symlinks for a directory
create_symlinks() {
	local dir="$1"
	local target_dir="$2"

	if [ ! -d "$target_dir" ]; then
		echo "Target directory $target_dir does not exist. Creating..."
		mkdir -p "$target_dir"
	fi

	# Use stow to create symlinks
	print_log "$GREEN" "[+] Symlining Folder :: $dir"
	stow -vt "$target_dir" "$dir"
}

# Create symlinks for zsh
create_symlinks "zsh" "$HOME"
# Create symlinks for remaining folders
for folder in $DOT_FOLDERS; do
	create_symlinks "$folder" "$HOME/.config/$folder"
done

# Tweak some settings
print_header "$GREEN" "Changing the default shell to zsh."
current_shell=$(basename "$SHELL")

if [ "$current_shell" = "zsh" ]; then
	print_subheader "$LIGHT_PURPLE" "Zsh is already the default shell."
else
	print_subheader "$GREEN" "Changing default shell to Zsh..."
	chsh -s "$(which zsh)"
	print_log "$GREEN" "Default shell changed to Zsh."
fi

# Add current user to plugdev - For USB debugging & Tethering
print_header "$GREEN" "Adding current user to plugdev"
sudo groupadd plugdev
sudo usermod -aG plugdev "$LOGNAME"

print_subheader "$LIGHT_PURPLE" "Note: Starship is installed but isn't used"
print_subheader "$LIGHT_PURPLE" "Note: Tmux Plugin Manager is installed, Please press Prefix + I in a tmux session to load all the plugins"
print_subheader "$RED" "Note: Android Sdk, Android cmd-line tools and Android emulators are not installed."
print_log "$GREEN" "Dotfiles installation complete."
print_log "$GREEN" "System preferencs have been changed. Reboot Recommended."
echo ""
echo -n "Do you want to reload the shell? (Y/n):"
read response

# Convert the response to lowercase for case-insensitive comparison
response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ $response_lower == "y" ]]; then
	print_subheader "[+] Reloading shell..."
	exec >/dev/tty 2>&1 # Stop logging to text file before reloading the shell
	exec $SHELL -l
elif [[ $response_lower == "n" ]]; then
	print_log "$RED" "Please reload the shell to see the changes in effect."
else
	echo "Invalid response. Please enter 'Y/y' or 'N/n'."
fi
# Fin.
