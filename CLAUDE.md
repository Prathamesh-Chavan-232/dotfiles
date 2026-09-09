# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Linux dotfiles repo, primarily for Fedora 43/44 (Ubuntu/Arch supported as manifest data only). Configs are managed via GNU Stow and deployed through an interactive install script.

**Manual-first policy:** the install script is NOT for fresh systems. Fresh installs are done by hand so upstream method drift gets noticed; the script only re-provisions throwaway users/VMs after being validated against that manual install. Only plain distro-repo packages auto-install — repo+key / curl|bash / flatpak / language-runtime methods are flagged `MANUAL` instead. There is deliberately no `--all` or run-everything path.

## Key Commands

```bash
# Interactive looping menu (no "all" option)
./scripts/install.sh

# Explicit actions (combine freely)
./scripts/install.sh --dotfiles        # Symlink dotfiles only
./scripts/install.sh --plugins         # Install plugin managers (TPM, Zap)
./scripts/install.sh --system-packages # Select + install CLI tools
./scripts/install.sh --dev-tools       # Repo dev packages (runtimes stay manual)
./scripts/install.sh --repos           # RPM Fusion / openh264 / Flathub (Fedora)
./scripts/install.sh --docker          # Docker Engine (explicit opt-in, Fedora)
./scripts/install.sh --apps            # VS Code/Chrome/Brave/Spotify (opt-in only)
./scripts/install.sh --hyprland        # Handoff to upstream JaKoolit rice installer

# Global flags
./scripts/install.sh --dry-run ...         # Print packages/methods/commands; run nothing
./scripts/install.sh --force-runtimes ...  # Echo (never run) upstream runtime commands
./scripts/install.sh --distro fedora ...   # Override distro detection (testing)

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
| `starship` | `~/.config` (holds `starship.toml`) |
| `github-ssh` | SSH config for GitHub |

### Neovim Config (`nvim/`)

Built on **LazyVim** (lazy.nvim + LazyVim distro). Plugin specs are organized by concern:

- `lua/config/` — core settings: options, keymaps, autocmds, lazy.nvim bootstrap
- `lua/plugins/` — plugin specs split into subdirs: `ui/`, `editor/`, `coding/`, `lsp/`, `colorschemes/`
- `lua/craftzdog/` — custom utility modules (LSP helpers, HSL colors, discipline/cowboy mode)
- `lua/util/` — debug utilities

LazyVim extras enabled: TypeScript, Rust, Tailwind, JSON, Markdown, ESLint, Prettier, DAP, mini-files, yanky, project.

### Install Scripts (`scripts/`)

- `scripts/install.sh` — unified entry: distro detection (`/etc/os-release`), policy banner, `action_*` dispatch shared by the arg loop and the no-args looping menu
- `scripts/lib/` — the shared, data-driven core:
  - `manifest.sh` — logical tool → per-package-manager name (`PKG_<ID>`) + install method (`M_<ID>`); adding a tool = one `PKG_` line (+ method) + one `SELECTABLE` line
  - `pm.sh` — `install_pkg`/`install_group` with the method gate (only `repo` items auto-install; everything else prints `MANUAL`), `--dry-run` support, end-of-run summary
  - `select.sh` — confirm-driven selection UI over `SELECTABLE`
  - `menu.sh` — interactive looping menu
  - `ui.sh` — all output styling: palette, Nerd-Font glyphs with ASCII fallback, `NO_COLOR`/non-TTY auto-disable, ANSI-stripped logging, banner, boxes
- `scripts/fedora/` — the only wired backend (dnf5 syntax, Fedora 41+): `repos.sh`, `packages.sh` (bspwm stack), `dev-env.sh`, `docker.sh`, `apps.sh`
- `scripts/common/` — cross-distro: dotfile linking, plugin managers, GNOME settings, GitHub SSH keys, Hyprland upstream handoff
- `scripts/utils/` — `loggers.sh` (back-compat shim over `lib/ui.sh`), `confirm.sh` (y/n prompts), `system-link.sh` (stow wrapper)
- `scripts/ubuntu/` — legacy Ubuntu functions, kept as reference but NOT sourced by `install.sh`
- `scripts/install-*.old.sh` — legacy flat scripts, kept until the new Fedora path is validated on a real machine

The install script uses a `confirm()` function before each step; language runtimes (pyenv, nvm, SDKMAN, rustup) are never installed by the script — `--force-runtimes` only echoes the upstream commands.
