#!/bin/bash

# Installer
install_packages() {
    local package_list=("$@")

    for package in "${package_list[@]}"; do
        if dpkg --get-selections | grep -q "^$package\$"; then
            print_subheader "$LIGHT_PURPLE" "$package is already installed."
        else
            sudo apt-get install -y "$package"
            print_log "$GREEN" "$package installed successfully."
        fi
    done
}
