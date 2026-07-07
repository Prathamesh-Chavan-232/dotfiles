# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Linux dotfiles repo for Ubuntu 24.04. Configs are managed via GNU Stow and deployed through an interactive install script.

## Key Commands

```bash
# Full interactive install
./scripts/install.sh

# Install specific components (non-interactive)
./scripts/install.sh --dotfiles        # Symlink dotfiles only
./scripts/install.sh --plugins         # Install plugin managers (TPM, Zap)
./scripts/install.sh --all             # Everything, no prompts

# See all flags
./scripts/install.sh --help
```

## Architecture

### Dotfile Packages (Stow-based)

Each top-level directory is a stow package. `scripts/common/link-dotfiles.sh` uses `stow -vt <target> <package>` to symlink them:

| Package | Target |
|---------|--------|
| `zsh` | `$HOME` (contains `.zshrc`) |
| `vim` | `$HOME` |
| `nvim` | `~/.config/nvim` |
| `nvim-code` | `~/.config/nvim-code` |
| `tmux` | `~/.config/tmux` |
| `wezterm` | `~/.config/wezterm` |
| `starship` | Starship prompt config |
| `github-ssh` | SSH config for GitHub |

### Neovim Config (`nvim/`)

Built on **LazyVim** (lazy.nvim + LazyVim distro). Plugin specs are organized by concern:

- `lua/config/` — core settings: options, keymaps, autocmds, lazy.nvim bootstrap
- `lua/plugins/` — plugin specs split into subdirs: `ui/`, `editor/`, `coding/`, `lsp/`, `colorschemes/`
- `lua/craftzdog/` — custom utility modules (LSP helpers, HSL colors, discipline/cowboy mode)
- `lua/util/` — debug utilities

LazyVim extras enabled: TypeScript, Rust, Tailwind, JSON, Markdown, ESLint, Prettier, DAP, mini-files, yanky, project.

### Install Scripts (`scripts/`)

- `scripts/install.sh` — entry point; sources all other scripts and orchestrates install
- `scripts/ubuntu/` — Ubuntu-specific: packages, dev environments (Python/Node/Go/Java/Rust), Docker
- `scripts/common/` — cross-distro: dotfile linking, GNOME settings, GitHub SSH keys
- `scripts/utils/` — shared helpers: `loggers.sh` (colored output), `confirm.sh` (y/n prompts), `system-link.sh` (stow wrapper)

The install script uses a `confirm()` function before each step. The `--all` flag overrides `confirm()` to always return true.
