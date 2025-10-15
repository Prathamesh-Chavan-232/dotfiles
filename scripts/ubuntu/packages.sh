#!/bin/bash

# Ubuntu package installation utilities

install_apt_packages() {
    local packages=("$@")
    if [ ${#packages[@]} -eq 0 ]; then
        return
    fi
    
    print_subheader "$GREEN" "Installing: ${packages[*]}"
    for package in "${packages[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            print_log "$LIGHT_PURPLE" "$package is already installed"
        else
            sudo apt install -y "$package" || print_log "$RED" "Failed to install $package"
        fi
    done
}

system_update() {
    if confirm "Update system packages?"; then
        print_header "$GREEN" "Updating system"
        sudo apt update && sudo apt upgrade -y
    fi
}

install_system_packages() {
    if confirm "Install system workflow packages?"; then
        print_header "$GREEN" "Installing System Packages"
        
        local system_packages=()
        
        echo ""
        print_subheader "$YELLOW" "Select packages to install:"
        
        confirm "- Tmux (terminal multiplexer)?" && system_packages+=("tmux")
        confirm "- Zsh (shell)?" && system_packages+=("zsh")
        confirm "- Stow (dotfile manager)?" && system_packages+=("stow")
        confirm "- Ripgrep (search tool)?" && system_packages+=("ripgrep")
        confirm "- Fzf (fuzzy finder)?" && system_packages+=("fzf")
        confirm "- Fd (find alternative)?" && system_packages+=("fd-find")
        confirm "- Bat (cat alternative)?" && system_packages+=("bat")
        confirm "- Xclip (clipboard tool)?" && system_packages+=("xclip")
        confirm "- Zoxide (cd with fzf)?" && system_packages+=("zoxide")
        confirm "- Lsd (A better ls)?" && system_packages+=("lsd")

        if confirm "- Wezterm (terminal emulator)?"; then
            print_subheader "$GREEN" "Adding Wezterm repository & GPG key"
            curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
            echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
            sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

            print_subheader "$GREEN" "Updating package lists"
            sudo apt update

            system_packages+=("wezterm")
        fi
        
        install_apt_packages "${system_packages[@]}"
        
        # Install additional tools via cargo
        if command -v cargo &> /dev/null; then
            local cargo_packages=()
            confirm "- Starship (shell prompt)?" && cargo_packages+=("starship")
            confirm "- Lsd (ls alternative)?" && cargo_packages+=("lsd")
            confirm "- Dust (du alternative)?" && cargo_packages+=("du-dust")
            
            for pkg in "${cargo_packages[@]}"; do
                if ! command -v "$pkg" &> /dev/null; then
                    print_subheader "$GREEN" "Installing $pkg via cargo"
                    cargo install "$pkg"
                fi
            done
        fi
    fi
}

install_editors() {
    if confirm "Install code editors/IDEs?"; then
        print_header "$GREEN" "Installing Code Editors"
        
        if confirm "Install VS Code?"; then
            if ! command -v code &> /dev/null; then
                print_subheader "$GREEN" "Installing VS Code"
                wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
                sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
                rm -f packages.microsoft.gpg
                sudo apt update
                install_apt_packages "code"
            fi
        fi

        if confirm "Install Neovim via bob (version manager)?"; then
            if ! command -v bob &> /dev/null; then
                install_neovim
            else
                print_log "$LIGHT_PURPLE" "bob is already installed"
            fi
        fi
    fi
}

install_browsers() {
    if confirm "Install web browsers?"; then
        print_header "$GREEN" "Installing Web Browsers"
        
        if confirm "Install Google Chrome?"; then
            if ! command -v google-chrome &> /dev/null; then
                print_subheader "$GREEN" "Installing Google Chrome"
                
                # Download and install the .deb package
                # This automatically adds the Google repository for updates
                wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt --fix-broken install -y
                rm google-chrome-stable_current_amd64.deb
                
                # Verify repository was added
                if [ -f /etc/apt/sources.list.d/google-chrome.list ]; then
                    print_log "$GREEN" "Google Chrome repository added - will receive updates via apt"
                else
                    print_log "$YELLOW" "Repository not found, Chrome may not auto-update"
                fi
            else
                print_log "$LIGHT_PURPLE" "Google Chrome is already installed"
            fi
        fi
        
        if confirm "Install Firefox?"; then
            install_apt_packages "firefox"
        fi
    fi
}

install_gnome_tools() {
    if confirm "Install GNOME tools and extensions?"; then
        print_header "$GREEN" "Installing GNOME Tools"
        
        local gnome_packages=()
        confirm "- GNOME Tweaks?" && gnome_packages+=("gnome-tweaks")
        confirm "- GNOME Extensions?" && gnome_packages+=("gnome-shell-extensions")
        confirm "- dconf-cli (for settings backup)?" && gnome_packages+=("dconf-cli")
        
        install_apt_packages "${gnome_packages[@]}"
        
        print_log "$YELLOW" "Recommended GNOME Extensions (install via extensions.gnome.org):"
        print_subheader "$YELLOW" "  - Just Perfection"
        print_subheader "$YELLOW" "  - User Themes"
        print_subheader "$YELLOW" "  - No Overview at Startup"
        print_subheader "$YELLOW" "  - Forge"
        print_subheader "$YELLOW" "  - Blur My Shell"
        print_subheader "$YELLOW" "  - Media Controls"
    fi
}

install_neovim() {
    # Installing Neovim
    print_header "$GREEN" "Installing Neovim & Neovim version manager"
    cargo install --git https://github.com/MordechaiHadad/bob.git
}

install_pnpm() {
    # Install pnpm
    print_header "$GREEN" "Installing pnpm"
    curl -fsSL https://get.pnpm.io/install.sh | sh -
}

install_cermic() {
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
}

install_plugin_managers() {	
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
}


