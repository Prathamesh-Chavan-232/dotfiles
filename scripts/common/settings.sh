# Setup shell
setup_zsh() {
    if confirm "Change default shell to Zsh?"; then
        if command -v zsh &> /dev/null; then
            print_header "$GREEN" "Setting up Zsh as default shell"
            if [ "$SHELL" != "$(which zsh)" ]; then
                chsh -s "$(which zsh)"
                print_log "$GREEN" "Default shell changed to Zsh. Please log out and back in."
            else
                print_log "$LIGHT_PURPLE" "Zsh is already the default shell"
            fi
        else
            print_log "$RED" "Zsh is not installed"
        fi
    fi
}

set_shell_settings() {

    # Handle time differences between windows and linux
    print_header "$GREEN" "Switching to local clock"
    timedatectl set-local-rtc 1 --adjust-system-clock

    # Add current user to plugdev - For USB debugging & Tethering
    # print_header "$GREEN" "Adding current user to plugdev"
    # sudo groupadd plugdev
    # sudo usermod -aG plugdev "$LOGNAME"

    setup_zsh
}
