#!/bin/bash

load_gnome_settings() {
	if confirm "Porting GNOME settings have installed the required extensions from the README?"; then
		print_subheader "[+] Porting GNOME settings,shortcuts and extensions..."
		dconf load / <gnome-settings.dconf
	else
		print_log "$RED" "Skipping GNOME Settings installation."
	fi
}

