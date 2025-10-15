#!/bin/bash

link_dotfiles() {
    if confirm "Link dotfiles?"; then
        print_header "$GREEN" "Linking Dotfiles"
        
        # Ensure stow is installed
        if ! command -v stow &> /dev/null; then
            print_log "$RED" "stow is not installed. Please install it first."
            return 1
        fi
        
        # Backup existing configs
        if confirm "Backup existing config files?"; then
            print_header "$LIGHT_PURPLE" "Backing up existing config files"
            [ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
            [ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
            [ -d "$HOME/.config/nvim-code" ] && mv "$HOME/.config/nvim-code" "$HOME/.config/nvim-code.bak"
            [ -d "$HOME/.config/nvim-alt" ] && mv "$HOME/.config/nvim-alt" "$HOME/.config/nvim-alt.bak"
            [ -d "$HOME/.config/nvim-lazy" ] && mv "$HOME/.config/nvim-lazy" "$HOME/.config/nvim-lazy.bak"
            [ -d "$HOME/.config/tmux" ] && mv "$HOME/.config/tmux" "$HOME/.config/tmux.bak"
            [ -d "$HOME/.config/vim" ] && mv "$HOME/.config/vim" "$HOME/.config/vim.bak"
        fi

        echo ""
        print_subheader "$YELLOW" "Select dotfiles to link:"
        
        # Change to dotfiles directory for stow
        cd "$DOTFILES_DIR" || return 1
        
        # Zsh
        if confirm "- Zsh config?" && [ -d "zsh" ]; then
            create_symlink "zsh" "$HOME"
        fi

        # Vim
        if confirm "- Vim config?" && [ -d "vim" ]; then
            create_symlink "vim" "$HOME"
        fi
        
        # Neovim configs
        if confirm "- Neovim config?" && [ -d "nvim" ]; then
            create_symlink "nvim" "$HOME/.config/nvim"
        fi
        
        if confirm "- Neovim-code config?" && [ -d "nvim-code" ]; then
            create_symlink "nvim-code" "$HOME/.config/nvim-code"
        fi
        
        # Tmux
        if confirm "- Tmux config?" && [ -d "tmux" ]; then
            create_symlink "tmux" "$HOME/.config/tmux"
        fi
        
        # Wezterm
        if confirm "- Wezterm config?" && [ -d "wezterm" ]; then
            create_symlink "wezterm" "$HOME/.config/wezterm"
        fi
        
        print_log "$GREEN" "Dotfiles linking completed!"
    fi
}
