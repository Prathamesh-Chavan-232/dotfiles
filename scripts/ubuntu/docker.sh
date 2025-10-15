#!/bin/bash

# Docker installation for Ubuntu

install_docker() {
    if confirm "Install Docker?"; then
        print_header "$GREEN" "Installing Docker"
        
        if ! command -v docker &> /dev/null; then
            # Remove old versions
            print_subheader "$GREEN" "Removing old Docker versions"
            sudo apt remove docker docker-engine docker.io containerd runc 2>/dev/null || true
            
            # Install prerequisites
            install_apt_packages "ca-certificates" "curl" "gnupg" "lsb-release"
            
            # Add Docker's official GPG key
            print_subheader "$GREEN" "Adding Docker GPG key"
            sudo install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            sudo chmod a+r /etc/apt/keyrings/docker.gpg
            
            # Add repository
            print_subheader "$GREEN" "Adding Docker repository"
            echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            
            sudo apt update
            install_apt_packages "docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin"
            
            # Add user to docker group
            if confirm "Add current user to docker group (non-root access)?"; then
                print_subheader "$GREEN" "Adding user to docker group"
                sudo groupadd docker 2>/dev/null || true
                sudo usermod -aG docker "$USER"
                newgrp docker
                print_log "$YELLOW" "You may need to log out and back in for docker group changes to take effect"
            fi
            
            # Start and enable Docker
            print_subheader "$GREEN" "Starting Docker service"
            sudo systemctl start docker
            sudo systemctl enable docker
            
            # Verify installation
            if confirm "Verify Docker installation with hello-world?"; then
                print_subheader "$GREEN" "Verifying Docker installation"
                docker run hello-world
            fi
            
            print_log "$GREEN" "Docker installed successfully"
        else
            print_log "$LIGHT_PURPLE" "Docker is already installed"
        fi
    fi
}

install_docker_desktop() {
    if confirm "Install Docker Desktop (GUI)?"; then
        print_header "$GREEN" "Installing Docker Desktop"
        
        if ! command -v docker-desktop &> /dev/null && ! dpkg -l | grep -q docker-desktop; then
            print_subheader "$GREEN" "Docker Desktop provides a GUI for managing containers"
            
            # Check if Docker Engine is installed
            if ! command -v docker &> /dev/null; then
                print_log "$YELLOW" "Docker Engine is not installed. Installing Docker Engine first..."
                install_docker
            fi
            
            # Download Docker Desktop
            print_subheader "$GREEN" "Downloading Docker Desktop"
            DOCKER_DESKTOP_VERSION=$(curl -s https://desktop.docker.com/linux/main/amd64/docker-desktop.deb.sha256 | awk '{print $2}')
            wget -O /tmp/docker-desktop.deb "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"
            
            # Install Docker Desktop
            print_subheader "$GREEN" "Installing Docker Desktop package"
            sudo apt install -y /tmp/docker-desktop.deb || sudo apt --fix-broken install -y
            rm /tmp/docker-desktop.deb
            
            print_log "$GREEN" "Docker Desktop installed successfully"
            print_log "$YELLOW" "Launch Docker Desktop from your applications menu or run: systemctl --user start docker-desktop"
            
            # Note about system requirements
            print_log "$YELLOW" "Note: Docker Desktop requires:"
            print_subheader "$YELLOW" "  - KVM virtualization support"
            print_subheader "$YELLOW" "  - QEMU version 5.2 or newer"
            print_subheader "$YELLOW" "  - systemd init system"
            
            if confirm "Enable Docker Desktop to start on login?"; then
                systemctl --user enable docker-desktop
                print_log "$GREEN" "Docker Desktop will start automatically on login"
            fi
        else
            print_log "$LIGHT_PURPLE" "Docker Desktop is already installed"
        fi
    fi
}