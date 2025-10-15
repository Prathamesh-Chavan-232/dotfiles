#!/bin/bash

system_packages=("neovim" "alacritty" "lazygit" "zsh" "starship" "bat" "tmux" "firefox" "lsd" "zoxide" "stow" "ripgrep" "fzf" "xclip" "dust")
development_tools=("git" "github-cli" "python" "gcc" "docker")
code_editors=("visual-studio-code-bin" "android-studio")
browsers=("google-chrome" "brave-bin")
other_apps=("spotify")
sdks=("flutter")

print_header "$GREEN" "Installing Development Tools"
install_packages "pacman" "${development_tools[@]}"

# "dunst" "polybar" "i3" "rofi" "neofetch" "fastfetch" "picom" "ranger" "feh" "ueberzug" "htop"
print_header "$GREEN" "Installing System Workflow Apps"
install_packages "pacman" "${system_packages[@]}"

print_header "$GREEN" "Installing Code Editors"
install_packages "yay" "${code_editors[@]}"

print_header "$GREEN" "Installing Web Browsers"
install_packages "yay" "${browsers[@]}"

print_header "$GREEN" "Installing Other Useful Apps"
install_packages "yay" "${other_apps[@]}"

# Install Flutter
print_header "$GREEN" "Installing Flutter"
install_packages "yay" "${sdks[@]}"

print_log "$GREEN" "Installing Packages Completed."
echo ""
print_subheader "$GREEN" "Setting up a few things, for you please wait."

# Install conda
# print_header "$GREEN" "Installing Miniconda"
# # Check if Miniconda is already installed
# if command miniconda3 &>/dev/null; then
# 	print_subheader "$LIGHT_PURPLE" "Miniconda is already installed."
# else
# 	# Miniconda not found, install it
# 	print_log "$GREEN" "Miniconda is not installed. Installing Miniconda..."
#
# 	# Download and install Miniconda
# 	mkdir -p ~/miniconda3
# 	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
# 	bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
# 	rm -rf ~/miniconda3/miniconda.sh
#
# 	# Add Miniconda to PATH
# 	export PATH="$HOME/miniconda/bin:$PATH"
#
# 	print_log "$GREEN" "Miniconda installed successfully."
# fi

# print_header "$GREEN" "Installing Patched Fonts"
# patched_fonts=("ttf-jetbrains-mono-nerd")
# install_packages "yay" "${patched_fonts[@]}"
#
# print_header "$GREEN" "Installing Icon Theme"
# icon_themes=("numix-circle-icon-theme-git")
# install_packages "yay" "${icon_themes[@]}"



