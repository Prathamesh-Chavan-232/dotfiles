#!/bin/bash

# Loggers
# Define colors
RED='\033[0;31m'   # Red color
GREEN='\033[0;32m' # Green color
YELLOW='\033[0;33m'
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

# Adding third party repositories
print_header "$GREEN" "Adding RPM fusion repositories"
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

print_header "$GREEN" "Adding Flatpak repositories"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf makecache

# Updating the system
print_header "$GREEN" "Getting system updates"
sudo dnf update -y && sudo dnf upgrade

# Install Development Related Packages
print_header "$GREEN" "Installing Development Tools"
development_tools=("git" "python3" "python3-pip" "npm" "gcc" "gcc-c++" "make" "cmake" "rust" "cargo")
install_packages "dnf" "${development_tools[@]}"

# Installing Neovim
print_header "$GREEN" "Installing Neovim & Neovim version manager"
cargo install --git https://github.com/MordechaiHadad/bob.git

# Install docker
print_header "$GREEN" "Installing Docker"
# Uninstall old versions
sudo dnf remove docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-selinux \
	docker-engine-selinux \
	docker-engine

# Set up the repository
print_subheader "$GREEN" "Setting up repositories"
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# Install Docker Engine
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Start Docker.
sudo systemctl start docker

# Manage Docker as a non-root user
print_subheader "$GREEN" "Allow non-root users to use docker"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Verify that the Docker Engine installation is successful by running the hello-world image.
print_subheader "$GREEN" "Verifying Docker engine installtion"
docker run hello-world

# Install pnpm
print_header "$GREEN" "Installing pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Install Flutter
#print_header "$GREEN" "Installing Flutter"
#flatpak_packages=("io.flutter.flutter" "com.google.Android.NDK")
#install_packages "flatpak" "${flatpak_packages[@]}"

# Install driver & Kernel header tools
print_header "$GREEN" "Installing Kernel headers & Driver tools"
driver_tools=("kernel-devel" "kernel-headers" "dkms" "acpid" "libglvnd-glx" "libglvnd-opengl" "libglvnd-devel" "pkgconfig")
install_packages "dnf" "${driver_tools[@]}"
print_header "$GREEN" "Updaitng Drivers"
drivers=("akmod-nvidia" "xorg-x11-drv-nvidia-cuda")
install_packages "dnf" "${drivers[@]}"

# Install System Workflow Apps
config_packages=("stow" "dconf")
system_packages=("ripgrep" "fzf" "fd" "xclip")
i3_packages=("i3" "rofi" "polybar" "dunst" "picom" "ranger" "feh" "ueberzug")
workflow_packages=("firefox" "vim" "alacritty" "kitty" "tmux" "zsh" "starship" "gh")
fun_packages=("bat" "lsd" "zoxide" "lazygit" "dust" "htop" "btop" "neofetch" "fastfetch")

print_header "$GREEN" "Installing System Tools/Packages"
install_packages "dnf" "${system_packages[@]}"
print_header "$GREEN" "Installing Workflow Apps/Packages"
install_packages "dnf" "${workflow_packages[@]}"
print_header "$GREEN" "Installing Configuration Tools"
install_packages "dnf" "${config_packages[@]}"
print_header "$GREEN" "Installing i3WM Apps/Packages"
install_packages "dnf" "${i3_packages[@]}"
print_header "$GREEN" "Installing Fun Terminal Tools"
install_packages "dnf" "${fun_packages[@]}"

print_header "$GREEN" "Installing Code Editors"
# VScode repos
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
code_editors=("code" "android-studio")
install_packages "dnf" "${code_editors[@]}"

print_header "$GREEN" "Installing Web Browsers"
browsers=("google-chrome-stable" "brave-browser")
install_packages "dnf" "${browsers[@]}"

# Install Other Useful Apps
print_header "$GREEN" "Installing Other Useful Apps"
flatpak install flathub com.spotify.Client

# Install Icon Themes
print_header "$GREEN" "Installing Icon Theme"
icons_themes=("numix-icon-theme-circle")
install_packages "dnf" "${icon_themes[@]}"

print_header "$GREEN" "Installing GNOME Extensions Manager and Tweaks"
gnome_extensions=("gnome-extensions-app" "gnome-tweaks")
install_packages "dnf" "${gnome_extensions[@]}"

# Install Cermic {Display ASCII Art of images in the terminal}
print_header "$GREEN" "Installing cermic for coll ASCII Art"
git clone https://codeberg.org/Oglo12/cermic/
cd cermic/
cargo build --release
sudo mv target/release/cermic /usr/local/bin/
print_subheader "$GREEN" "Cermic Installed successfully."
print_subheader "$RED" "Removing cermic build files"
cd ..
rm -rf cermic

# Install Tmux Plugin Manager
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
print_subheader "$GREEN" "Zsh Plugin Manager (Zap) installed successfully."

print_log "$GREEN" "Installing Packages Completed."
echo ""
print_subheader "$GREEN" "Setting up a few things, for you please wait."

print_header "$LIGHT_PURPLE" "Backing up existing config files"
mv ~/.zshrc ~/.zshrc.bak

# Creating symlinks
print_header "$GREEN" "Linking your dotfiles..."

# Create symlinks for zsh
create_symlinks "zsh" "$HOME"

# Define the directories to be symlinked
DOT_FOLDERS="alacritty kitty nvim nvim-alt nvchad tmux starship"

# Create symlinks for remaining folders
for folder in $DOT_FOLDERS; do
	create_symlinks "$folder" "$HOME/.config/$folder"
done

# Add github account SSH Keys
print_header "${GREEN}" "Adding Github Accounts SSH keys"
# Personal account
if [ ! -f ~/.ssh/id_github_personal ]; then
	print_log "${GREEN}" "Creating SSH key for personal account..."
	ssh-keygen -t ed25519 -f ~/.ssh/id_github_personal
	ssh-add ~/.ssh/id_github_personal
	print_log "${GREEN}" "Personal account SSH key created successfully."
else
	print_log "${YELLOW}" "Personal account SSH key already exists."
fi

# Work account
if [ ! -f ~/.ssh/id_github_noovosoft ]; then
	print_log "${GREEN}" "Creating SSH key for work account..."
	ssh-keygen -t ed25519 -f ~/.ssh/id_github_noovosoft
	ssh-add ~/.ssh/id_github_noovosoft
	print_log "${GREEN}" "Work account SSH key created successfully."
else
	print_log "${YELLOW}" "Work account SSH key already exists."
fi

# Adding config file
print_subheader "${GREEN}" "Adding SSH keys config"
if [ ! -f ~/.ssh/config ]; then
	cp github-ssh/config ~/.ssh/
else
	print_log "${YELLOW}" "A Config file already exists."
fi

print_subheader "${GREEN}" "SSH keys setup completed."

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

echo ""
echo -n "Porting GNOME settings have installed the required extensions from the README? (Y/n):"
read response

# Convert the response to lowercase for case-insensitive comparison
response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ $response_lower == "y" ]]; then
	print_subheader "[+] Porting GNOME settings,shortcuts and extensions..."
	dconf load -f /org/gnome/ <gnome-settings.dconf

elif [[ $response_lower == "n" ]]; then
	print_log "$RED" "Skipping GNOME Settings installation."
else
	echo "Invalid response. Please enter 'Y/y' or 'N/n'."
fi

print_subheader "$LIGHT_PURPLE" "Note: Starship is installed but isn't used"
print_subheader "$LIGHT_PURPLE" "Note: Tmux Plugin Manager is installed, Please press Prefix + I in a tmux session to load all the plugins"
print_subheader "$LIGHT_PURPLE" "Note: To Apply the GNOME legacy apps and shell theme copy the theme folder to ~/.themes and for gtk4.0 copy the gtk4.0 folder to ~/.config"
print_subheader "$LIGHT_PURPLE" "Note: To be able to use custom fonts, download new fonts, unzip them and paste them in ~/.local/share/fonts then run fc-cache -v"
print_subheader "$RED" "Note: A Nerd Font is required for Alacritty, Kitty &  Neovim"
print_subheader "$RED" "Note: Flutter, Android Sdk, Android cmd-line tools and Android emulators are not installed."
print_subheader "$RED" "Note: Paste your SSH keys into your github profile(s) & test them."

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
