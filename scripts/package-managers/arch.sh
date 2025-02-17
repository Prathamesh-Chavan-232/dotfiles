#!/bin/bash
source "../common/loggers.sh"

# Installer
install_packages() {
	local package_manager="$1"
	shift
	local package_list=("$@")

	case "$package_manager" in
	"pacman")
		install_command="sudo pacman -S --noconfirm"
		check_command="pacman -Qs"
		;;
	"yay")
		install_command="yay -S --noconfirm"
		check_command="yay -Qs"
		;;
	"piaur")
		install_command="piaur -S --noconfirm"
		check_command="piaur -Qs"
		;;
	"snap")
		install_command="sudo snap install"
		check_command="snap list"
		;;
	*)
		print_subheader "$RED" "Unsupported package manager: $package_manager"
		exit 1
		;;
	esac

	for package in "${package_list[@]}"; do
		if $check_command "$package" &>/dev/null; then
			print_subheader "$LIGHT_PURPLE" "$package is already installed."
		else
			$install_command "$package"
			print_log "$GREEN" "$package installed successfully."
		fi
	done
}

