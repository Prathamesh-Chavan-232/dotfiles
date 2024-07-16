#!/bin/bash

# Detect distro
if [ -f /etc/fedora-release ]; then
    DISTRO="fedora"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
elif [ -f /etc/lsb-release ]; then
    DISTRO="ubuntu"
else
    echo "Unsupported distribution"
    exit 1
fi

# Detect if running in WSL
if grep -q Microsoft /proc/version; then
    ENV="wsl"
else
    ENV="full"
fi

# Source common scripts
source scripts/common/utils.sh
source scripts/common/development.sh
source scripts/common/system_apps.sh
source scripts/common/config_setup.sh

# Source distro-specific script
source scripts/distro-specific/${DISTRO}.sh

# Source environment-specific script if WSL
if [ "$ENV" == "wsl" ]; then
    source scripts/environments/wsl.sh
fi

# Setup zsh configuration
setup_zsh_config() {
    cat configs/zsh/zshrc.common > ~/.zshrc
    cat configs/zsh/zshrc.${DISTRO} >> ~/.zshrc
    if [ "$ENV" == "wsl" ]; then
        echo "# WSL-specific configurations" >> ~/.zshrc
        # Add WSL-specific zsh configurations here
    fi
}

# Run installations and setups
run_common_installations
run_distro_specific_installations
run_common_configs
setup_zsh_config

if [ "$ENV" == "full" ]; then
    run_full_env_setups
fi

print_header "Installation complete!"
