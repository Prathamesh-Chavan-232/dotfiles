#!/bin/bash

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

	print_log "$GREEN" "Installing Packages Completed."
	echo ""
	print_subheader "$GREEN" "Setting up a few things, for you please wait."

	print_header "$LIGHT_PURPLE" "Backing up existing config files"
	mv ~/.zshrc ~/.zshrc.bak
}


