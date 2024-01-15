#!/bin/bash

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOT_FOLDERS="alacritty,zsh,nvim,tmux,nvim-old,nvchad,kitty"

for folder in $(echo $DOT_FOLDERS | sed "s/,/ /g"); do
    echo "[+] Folder :: $folder"
    stow --ignore=README.md --ignore=LICENSE \
        -t $HOME -D $folder
    stow -v -t $HOME $folder
    echo "Symlinked: $folder"
done

# Reload shell once installed
echo "[+] Reloading shell..."
exec $SHELL -l


echo "Dotfiles installation complete."


