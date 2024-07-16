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
