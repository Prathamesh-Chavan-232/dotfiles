#!/bin/bash

# Ubuntu 24.04 Installation Script
# Interactive setup for development environment with dotfiles
# 
# Usage:
#   cd /path/to/dotfiles
#   ./scripts/install.sh

set -e

# Determine script and dotfiles directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source utility functions
source "$SCRIPT_DIR/utils/loggers.sh"
source "$SCRIPT_DIR/utils/confirm.sh"
source "$SCRIPT_DIR/utils/system-link.sh"

# Source Ubuntu-specific scripts
source "$SCRIPT_DIR/ubuntu/packages.sh"
source "$SCRIPT_DIR/ubuntu/dev-env.sh"
source "$SCRIPT_DIR/ubuntu/docker.sh"

# Source common scripts
source "$SCRIPT_DIR/common/link-dotfiles.sh"
source "$SCRIPT_DIR/common/gnome-settings.sh"
source "$SCRIPT_DIR/common/settings.sh"
source "$SCRIPT_DIR/common/fin.sh"

# Show help
show_help() {
    cat << EOF
Ubuntu 24.04 Development Environment Setup

Usage: 
    $0 [OPTION]

Options:
    (no args)           Run full interactive installation
    -h, --help          Show this help message
    --all               Install everything without prompts
    --update            Update system packages
    --dev-tools         Install development tools (Git, GCC, Rust)
    --python            Setup Python environment
    --nodejs            Setup Node.js environment (includes pnpm)
    --golang            Setup Go environment
    --java              Setup Java environment (SDKMAN)
    --docker            Install Docker Engine
    --docker-desktop    Install Docker Desktop (GUI)
    --system-packages   Install system packages (Neovim, Tmux, WezTerm, etc.)
    --editors           Install code editors (VS Code, IntelliJ IDEA)
    --browsers          Install web browsers (Chrome, Firefox)
    --gnome             Install GNOME tools and extensions
    --neovim            Install Neovim via bob
    --dotfiles          Link dotfiles
    --plugins           Install plugin managers (TPM, Zap)
    --gnome-settings    Load GNOME settings from dconf
    --shell             Setup Zsh as default shell

Examples:
    $0                          # Interactive installation
    $0 --docker                 # Install only Docker Engine
    $0 --docker-desktop         # Install Docker Desktop
    $0 --python --nodejs        # Install Python and Node.js environments
    $0 --dotfiles --plugins     # Link dotfiles and install plugins
    $0 --java --golang          # Install Java and Go environments

EOF
    exit 0
}

# Main menu
show_menu() {
    clear
    print_header "$GREEN" "Ubuntu 24.04 Development Environment Setup"
    echo ""
    print_subheader "$LIGHT_PURPLE" "Dotfiles Directory: $DOTFILES_DIR"
    print_subheader "$LIGHT_PURPLE" "Script Location: $SCRIPT_DIR"
    echo ""
    echo "This script will help you set up your development environment."
    echo "You'll be prompted before each installation step."
    echo ""
    echo "Tip: Run '$0 --help' to see available options for non-interactive mode"
    echo ""
    echo "Press Enter to continue..."
    read -r
}

# Main installation flow (interactive)
run_installation() {
    show_menu

    system_update

    install_dev_tools
    install_python_env
    install_nodejs_env
    install_golang_env
    install_java_env
    install_docker
    install_docker_desktop

    install_system_packages 
    install_editors
    install_browsers 
    
    link_dotfiles    
    install_plugin_managers 

    install_gnome_tools
    load_gnome_settings

    set_shell_settings 
    fin
}


main() {
    if [ $# -eq 0 ]; then
        # No arguments, run interactive mode
        run_installation
        return
    fi
    
    # Process each argument
    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help)
                show_help
                ;;
            --all)
                print_header "$GREEN" "Installing all components without prompts"

                # Override confirm function to always return true
                confirm() { return 0; }
                run_installation
                
                ;;
            --update)
                print_header "$GREEN" "Updating system packages"
                sudo apt update && sudo apt upgrade -y
                print_log "$GREEN" "System update completed"
                ;;
            --dev-tools)
                install_dev_tools
                ;;
            --python)
                install_python_env
                ;;
            --nodejs)
                install_nodejs_env
                ;;
            --golang)
                install_golang_env
                ;;
            --java)
                install_java_env
                ;;
            --docker)
                install_docker
                ;;
            --docker-desktop)
                install_docker_desktop
                ;;
            --system-packages)
                install_system_packages
                ;;
            --editors)
                install_editors
                ;;
            --browsers)
                install_browsers
                ;;
            --gnome)
                install_gnome_tools
                ;;
            --neovim)
                if ! command -v bob &> /dev/null; then
                    install_neovim
                else
                    print_log "$LIGHT_PURPLE" "bob is already installed"
                fi
                ;;
            --dotfiles)
                link_dotfiles
                ;;
            --plugins)
                install_plugin_managers
                ;;
            --gnome-settings)
                load_gnome_settings
                ;;
            --shell)
                setup_zsh
                ;;
            *)
                echo "Unknown option: $1"
                echo "Run '$0 --help' for usage information"
                exit 1
                ;;
        esac
        shift
    done
    
    # Show completion message if not help or all
    if [ "$1" != "-h" ] && [ "$1" != "--help" ] && [ "$1" != "--all" ]; then
        print_log "$GREEN" "Selected components installed successfully!"
        print_header "$GREEN" "Installation Complete!"
    fi
}

# Run main function with arguments
main "$@"