#!/bin/bash

load_gnome_settings() {
	echo ""
	echo -n "Porting GNOME settings have installed the required extensions from the README? (Y/n):"
	read response

	# Convert the response to lowercase for case-insensitive comparison
	response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')

	if [[ $response_lower == "y" ]]; then
		print_subheader "[+] Porting GNOME settings,shortcuts and extensions..."
		dconf load / <gnome-settings.dconf

	elif [[ $response_lower == "n" ]]; then
		print_log "$RED" "Skipping GNOME Settings installation."
	else
		echo "Invalid response. Please enter 'Y/y' or 'N/n'."
	fi
}

