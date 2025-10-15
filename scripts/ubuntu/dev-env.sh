#!/bin/bash

# Development environment setup for Ubuntu

install_dev_tools() {
    print_header "$GREEN" "Development Tools Installation"
    
    local dev_packages=()
    
    if confirm "Install Git?"; then
        dev_packages+=("git")
    fi
    
    if confirm "Install GitHub CLI?"; then
        if [ ! -f /etc/apt/sources.list.d/github-cli.list ]; then
            print_subheader "$GREEN" "Adding GitHub CLI repository"
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
            sudo apt update
        fi
        dev_packages+=("gh")
    fi
    
    if confirm "Install build essentials (gcc, g++, make)?"; then
        dev_packages+=("build-essential" "cmake" "pkg-config")
    fi
    
    if confirm "Install Rust and Cargo?"; then
        if ! command -v cargo &> /dev/null; then
            print_subheader "$GREEN" "Installing Rust"
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source "$HOME/.cargo/env"
        else
            print_log "$LIGHT_PURPLE" "Rust is already installed"
        fi
    fi
    
    install_apt_packages "${dev_packages[@]}"
}

install_python_env() {
    if confirm "Setup Python development environment?"; then
        print_header "$GREEN" "Setting up Python environment"
        
        local python_packages=("python3" "python3-pip" "python3-venv")
        install_apt_packages "${python_packages[@]}"
        
        if confirm "Install pyenv for Python version management?"; then
            if [ ! -d "$HOME/.pyenv" ]; then
                print_subheader "$GREEN" "Installing pyenv"
                curl https://pyenv.run | bash
                
                # Add to environment
                export PYENV_ROOT="$HOME/.pyenv"
                export PATH="$PYENV_ROOT/bin:$PATH"
                eval "$(pyenv init -)"
                eval "$(pyenv virtualenv-init -)"
                
                print_log "$GREEN" "pyenv installed. Add to your shell profile:"
                print_subheader "$YELLOW" 'export PYENV_ROOT="$HOME/.pyenv"'
                print_subheader "$YELLOW" 'export PATH="$PYENV_ROOT/bin:$PATH"'
                print_subheader "$YELLOW" 'eval "$(pyenv init -)"'
                print_subheader "$YELLOW" 'eval "$(pyenv virtualenv-init -)"'
            else
                print_log "$LIGHT_PURPLE" "pyenv is already installed"
            fi
        fi
    fi
}

install_nodejs_env() {
    if confirm "Setup Node.js/JavaScript development environment?"; then
        print_header "$GREEN" "Setting up Node.js environment"
        
        if confirm "Install Node.js via apt?"; then
            install_apt_packages "nodejs" "npm"
        fi
        
        if confirm "Install nvm for Node.js version management?"; then
            if [ ! -d "$HOME/.nvm" ]; then
                print_subheader "$GREEN" "Installing nvm"
                curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
                
                export NVM_DIR="$HOME/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                
                if confirm "Install latest Node.js LTS via nvm?"; then
                    nvm install --lts
                    nvm use --lts
                fi
            else
                print_log "$LIGHT_PURPLE" "nvm is already installed"
                # Source nvm for current session
                export NVM_DIR="$HOME/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
            fi
        fi
        
        # Package manager options
        print_header "$GREEN" "Package Manager Setup"
        print_log "$YELLOW" "Choose your Node.js package manager approach:"
        echo ""
        
        if confirm "Install pnpm?"; then
            print_subheader "$YELLOW" "pnpm Installation Method:"
            echo ""
            print_log "$LIGHT_PURPLE" "1. Corepack (Recommended): Per-project pnpm versions"
            print_log "$LIGHT_PURPLE" "2. Standalone: Global pnpm installation"
            echo ""
            
            if confirm "Use Corepack for pnpm version management? (Recommended)"; then
                # Enable Corepack (comes with Node.js 16.13+)
                if command -v node &> /dev/null; then
                    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
                    if [ "$NODE_VERSION" -ge 16 ]; then
                        print_subheader "$GREEN" "Enabling Corepack"
                        corepack enable
                        
                        if confirm "Set pnpm version?"; then
                            print_log "$YELLOW" "Version options:"
                            print_subheader "$YELLOW" "  - latest (newest stable)"
                            print_subheader "$YELLOW" "  - 9 (latest 9.x)"
                            print_subheader "$YELLOW" "  - 8 (latest 8.x)"
                            print_subheader "$YELLOW" "  - 9.1.0 (specific version)"
                            echo ""
                            echo -n "Enter pnpm version (latest/9/8/9.1.0): "
                            read -r PNPM_VERSION
                            
                            if [ -n "$PNPM_VERSION" ]; then
                                corepack prepare pnpm@"$PNPM_VERSION" --activate
                                print_log "$GREEN" "pnpm@$PNPM_VERSION activated via Corepack"
                            fi
                        fi
                        
                        print_log "$GREEN" "Corepack enabled for pnpm"
                        print_log "$YELLOW" "Usage:"
                        print_subheader "$YELLOW" '  - Add to package.json: "packageManager": "pnpm@9.1.0"'
                        print_subheader "$YELLOW" "  - Corepack will auto-use the correct version per project"
                    else
                        print_log "$RED" "Node.js 16.13+ required for Corepack. Using standalone installation."
                        if ! command -v pnpm &> /dev/null; then
                            install_pnpm
                        fi
                    fi
                else
                    print_log "$RED" "Node.js not found. Install Node.js first."
                fi
            else
                # Standalone pnpm installation
                if ! command -v pnpm &> /dev/null; then
                    install_pnpm
                else
                    print_log "$LIGHT_PURPLE" "pnpm is already installed"
                fi
            fi
        fi
        
        if confirm "Install bun?"; then
            if ! command -v bun &> /dev/null; then
                print_subheader "$GREEN" "Installing bun"
                curl -fsSL https://bun.sh/install | bash
            else
                print_log "$LIGHT_PURPLE" "bun is already installed"
            fi
        fi
        
        # Information about package managers
        echo ""
        print_log "$LIGHT_PURPLE" "Package Manager Notes:"
        print_subheader "$LIGHT_PURPLE" "  - Corepack: Per-project version management (recommended)"
        print_subheader "$LIGHT_PURPLE" "  - Standalone: Single global version"
        print_subheader "$LIGHT_PURPLE" "  - You can use both: Corepack overrides when packageManager is specified"
    fi
}

install_golang_env() {
    if confirm "Setup Go development environment?"; then
        print_header "$GREEN" "Setting up Go environment"
        
        if ! command -v go &> /dev/null; then
            print_subheader "$GREEN" "Installing Go"
            
            # Get latest Go version
            GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
            print_log "$GREEN" "Installing $GO_VERSION"
            
            # Download and install
            wget "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
            sudo rm -rf /usr/local/go
            sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-amd64.tar.gz"
            rm "${GO_VERSION}.linux-amd64.tar.gz"
            
            # Add to PATH
            export PATH=$PATH:/usr/local/go/bin
            
            print_log "$GREEN" "Go installed successfully"
            print_log "$YELLOW" "Add to your shell profile:"
            print_subheader "$YELLOW" 'export PATH=$PATH:/usr/local/go/bin'
            print_subheader "$YELLOW" 'export PATH=$PATH:$HOME/go/bin'
        else
            print_log "$LIGHT_PURPLE" "Go is already installed: $(go version)"
        fi
    fi
}

install_java_env() {
    if confirm "Setup Java development environment?"; then
        print_header "$GREEN" "Setting up Java environment"
        
        if confirm "Install SDKMAN for Java version management?"; then
            if [ ! -d "$HOME/.sdkman" ]; then
                print_subheader "$GREEN" "Installing SDKMAN"
                curl -s "https://get.sdkman.io" | bash
                
                # Source SDKMAN
                export SDKMAN_DIR="$HOME/.sdkman"
                [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
                
                print_log "$GREEN" "SDKMAN installed successfully"
                
                if confirm "Install Java LTS versions via SDKMAN?"; then
                    print_subheader "$GREEN" "Available Java versions: 8, 11, 17, 21"
                    
                    if confirm "  - Install Java 21 (Latest LTS)?"; then
                        sdk install java 21.0.1-tem
                    fi
                    
                    if confirm "  - Install Java 17 (LTS)?"; then
                        sdk install java 17.0.9-tem
                    fi
                    
                    if confirm "  - Install Java 11 (LTS)?"; then
                        sdk install java 11.0.21-tem
                    fi
                fi
            else
                print_log "$LIGHT_PURPLE" "SDKMAN is already installed"
            fi
        else
            if confirm "Install default Java (OpenJDK) via apt?"; then
                print_subheader "$GREEN" "Select Java version to install:"
                
                local java_packages=()
                confirm "  - OpenJDK 21?" && java_packages+=("openjdk-21-jdk")
                confirm "  - OpenJDK 17?" && java_packages+=("openjdk-17-jdk")
                confirm "  - OpenJDK 11?" && java_packages+=("openjdk-11-jdk")
                
                install_apt_packages "${java_packages[@]}"
            fi
        fi
    fi
}