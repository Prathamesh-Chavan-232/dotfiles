#!/bin/bash

source "./scripts/utils/loggers.sh"
source "./scripts/utils/system-link.sh"
source "./scripts/common/link-dotfiles.sh"
source "./scripts/common/github-keys.sh"
source "./scripts/common/packages.sh"

link_dotfiles
setup_github_keys

# install_neovim
# install_plugin_managers
