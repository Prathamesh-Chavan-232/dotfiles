# Installer
install_packages() {
	local package_manager="$1"
	shift
	local package_list=("$@")

	case "$package_manager" in
	"dnf")
		install_command="sudo dnf install -y"
		check_command="dnf list installed"
		;;
	"flatpak")
		install_command="flatpak install -y"
		check_command="flatpak list --app --columns=application"
		;;
	*)
		print_subheader "$RED" "Unsupported package manager: $package_manager"
		exit 1
		;;
	esac

	for package in "${package_list[@]}"; do
		if $check_command | grep -q "^$package\$"; then
			print_subheader "$LIGHT_PURPLE" "$package is already installed."
		else
			$install_command "$package"
			print_log "$GREEN" "$package installed successfully."
		fi
	done
}

add_repos() {
    # Adding third party repositories
    print_header "$GREEN" "Adding RPM fusion repositories"
    sudo dnf config-manager --enable fedora-cisco-openh264
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    print_header "$GREEN" "Adding Flatpak repositories"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo dnf makecache
}

update_system() {
    # Updating the system
    print_header "$GREEN" "Getting system updates"
    sudo dnf update -y && sudo dnf upgrade
}

install_docker() {
    # Install docker
    print_header "$GREEN" "Installing Docker"
    # Uninstall old versions
    sudo dnf remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-selinux \
        docker-engine-selinux \
        docker-engine

    # Set up the repository
    print_subheader "$GREEN" "Setting up repositories"
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    # Install Docker Engine
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # Start Docker.
    sudo systemctl start docker

    # Manage Docker as a non-root user
    print_subheader "$GREEN" "Allow non-root users to use docker"
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    # Verify that the Docker Engine installation is successful by running the hello-world image.
    print_subheader "$GREEN" "Verifying Docker engine installtion"
    docker run hello-world
}

install_vscode() {
    print_header "$GREEN" "Installing Code Editors"
    # VScode repos
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    code_editors=("code" "android-studio")
    install_packages "dnf" "${code_editors[@]}"
}

install_apps() {
    # Development Tools
    development_tools=("git" "python3" "python3-pip" "npm" "gcc" "gcc-c++" "make" "cmake" "rust" "cargo")

    # Drivers
    driver_tools=("kernel-devel" "kernel-headers" "dkms" "acpid" "libglvnd-glx" "libglvnd-opengl" "libglvnd-devel" "pkgconfig")
    drivers=("akmod-nvidia" "xorg-x11-drv-nvidia-cuda")

    # System Apps
    config_packages=("stow" "dconf")
    system_packages=("ripgrep" "fzf" "fd" "xclip")
    workflow_packages=("firefox" "vim" "alacritty" "kitty" "tmux" "zsh" "starship" "gh" "bat" "lsd" "zoxide" "lazygit" )
    fun_packages=("dust" "htop" "btop" "neofetch" "fastfetch")
    i3_packages=("i3" "rofi" "polybar" "dunst" "picom" "ranger" "feh" "ueberzug")

    #Browsers
    browsers=("google-chrome-stable" "brave-browser")

    # gnome utilities
    gnome_utils=("gnome-extensions-app" "gnome-tweaks")

    # Install Development Related Packages
    print_header "$GREEN" "Installing Development Tools"
    install_packages "dnf" "${development_tools[@]}"

    # Install driver & Kernel header tools
    print_header "$GREEN" "Installing Kernel headers & Driver tools"
    install_packages "dnf" "${driver_tools[@]}"
    print_header "$GREEN" "Updaitng Drivers"
    install_packages "dnf" "${drivers[@]}"

    # Install System Apps
    print_header "$GREEN" "Installing System Tools/Packages"
    install_packages "dnf" "${system_packages[@]}"
    print_header "$GREEN" "Installing Workflow Apps/Packages"
    install_packages "dnf" "${workflow_packages[@]}"
    print_header "$GREEN" "Installing Configuration Tools"
    install_packages "dnf" "${config_packages[@]}"
    print_header "$GREEN" "Installing i3WM Apps/Packages"
    install_packages "dnf" "${i3_packages[@]}"
    print_header "$GREEN" "Installing Fun Terminal Tools"
    install_packages "dnf" "${fun_packages[@]}"

    # Install Browsers
    print_header "$GREEN" "Installing Web Browsers"
    install_packages "dnf" "${browsers[@]}"

    # Install Other Useful Apps
    print_header "$GREEN" "Installing Other Useful Apps"
    flatpak install flathub com.spotify.Client

    # Install GNOME Utils
    print_header "$GREEN" "Installing GNOME Extensions Manager and Tweaks"
    install_packages "dnf" "${gnome_utils[@]}"
}


# Install Flutter
#print_header "$GREEN" "Installing Flutter"
#flatpak_packages=("io.flutter.flutter" "com.google.Android.NDK")
#install_packages "flatpak" "${flatpak_packages[@]}"


