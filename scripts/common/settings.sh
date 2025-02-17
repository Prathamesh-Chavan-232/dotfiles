set_common_preferences() {

    # Handle time differences between windows and linux
    print_header "$GREEN" "Switching to local clock"
    timedatectl set-local-rtc 1 --adjust-system-clock

    # Add current user to plugdev - For USB debugging & Tethering
    print_header "$GREEN" "Adding current user to plugdev"
    sudo groupadd plugdev
    sudo usermod -aG plugdev "$LOGNAME"

    print_header "$GREEN" "Changing the default shell to zsh."
    current_shell=$(basename "$SHELL")

    if [ "$current_shell" = "zsh" ]; then
        print_subheader "$LIGHT_PURPLE" "Zsh is already the default shell."
    else
        print_subheader "$GREEN" "Changing default shell to Zsh..."
        chsh -s "$(which zsh)"
        print_log "$GREEN" "Default shell changed to Zsh."
    fi
}
