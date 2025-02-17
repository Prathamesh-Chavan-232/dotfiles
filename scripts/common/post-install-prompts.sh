post_install_prompts() {
    print_subheader "$LIGHT_PURPLE" "Note: Tmux Plugin Manager is installed, Please press Prefix + I in a tmux session to load all the plugins"
    print_subheader "$RED" "Note: Android Sdk, Android cmd-line tools and Android emulators are not installed."
    print_log "$GREEN" "Dotfiles installation complete."
    print_log "$GREEN" "System preferencs have been changed. Please Reboot."
    echo ""
    echo -n "Do you want to reload the shell? (Y/n):"
    read response

    # Convert the response to lowercase for case-insensitive comparison
    response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [[ $response_lower == "y" ]]; then
      print_subheader "[+] Reloading shell..."
      exec >/dev/tty 2>&1 # Stop logging to text file before reloading the shell
      exec $SHELL -l
      # Add your code here for the 'yes' case
    elif [[ $response_lower == "n" ]]; then
      # Add your code here for the 'no' case
      print_log "$RED" "Please reload the shell to see the changes in effect."
    else
      echo "Invalid response. Please enter 'Y/y' or 'N/n'."
    fi
}
