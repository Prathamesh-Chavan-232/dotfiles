#!/usr/bin/env bash
# manifest.sh — the single source of truth for package selection (DATA ONLY).
#
# Adding a tool = one PKG_<ID> line (+ optional M_<ID> method) + one SELECTABLE
# (or DEV_TOOLS_IDS) line. It then surfaces on every distro automatically.
#
# PKG_<ID>  : associative array, package-manager -> package name(s).
#             The value MAY be a space-separated list (e.g. build tools, python
#             meta-packages); every token is installed.
# M_<ID>    : associative array, package-manager -> INSTALL METHOD. Optional;
#             a tool with no M_<ID> defaults to `repo`.
#
# INSTALL METHODS (only `repo` is ever scripted; the rest are flagged MANUAL):
#   repo      plain `<pm> install <pkg>` from the distro's OWN repos      (safe)
#   repo+key  needs a third-party repo / GPG key added first             (manual)
#   script    upstream curl|bash installer — method drifts               (manual)
#   vcs+build git clone + cargo/make build                               (manual)
#   flatpak   flatpak install                                            (manual)
#   runtime   language runtime / version manager — ALWAYS manual on fresh(manual)
#
# Methods are conservative on purpose: when a package's availability on a distro
# is uncertain we mark `script` (flagged MANUAL, harmless) rather than `repo`
# (which would attempt — and possibly fail — an install). Under-flagging costs a
# failed install; over-flagging costs nothing but a by-hand note.

# Data-only file: every array here is consumed dynamically via nameref in
# lib/pm.sh (PKG_$id / M_$id), which shellcheck cannot see.
# shellcheck disable=SC2034

# Guard against double-sourcing.
[ -n "${_MANIFEST_SH_LOADED:-}" ] && return 0
_MANIFEST_SH_LOADED=1

# ---------------------------------------------------------------------------
# Core CLI tools (offered by --system-packages / the selection UI).
# ---------------------------------------------------------------------------
declare -A PKG_TMUX=(      [apt]=tmux        [dnf]=tmux        [pacman]=tmux        )
declare -A PKG_ZSH=(       [apt]=zsh         [dnf]=zsh         [pacman]=zsh         )
declare -A PKG_STOW=(      [apt]=stow        [dnf]=stow        [pacman]=stow        )
declare -A PKG_RG=(        [apt]=ripgrep     [dnf]=ripgrep     [pacman]=ripgrep     )
declare -A PKG_FZF=(       [apt]=fzf         [dnf]=fzf         [pacman]=fzf         )
declare -A PKG_FD=(        [apt]=fd-find     [dnf]=fd-find     [pacman]=fd          )
declare -A PKG_BAT=(       [apt]=bat         [dnf]=bat         [pacman]=bat         )
declare -A PKG_LSD=(       [apt]=lsd         [dnf]=lsd         [pacman]=lsd         )
declare -A PKG_ZOXIDE=(    [apt]=zoxide      [dnf]=zoxide      [pacman]=zoxide      )
declare -A PKG_NVIM=(      [apt]=neovim      [dnf]=neovim      [pacman]=neovim      )
declare -A PKG_FASTFETCH=( [apt]=fastfetch   [dnf]=fastfetch   [pacman]=fastfetch   )
declare -A PKG_UNZIP=(     [apt]=unzip       [dnf]=unzip       [pacman]=unzip       )
declare -A PKG_FIREFOX=(   [apt]=firefox     [dnf]=firefox     [pacman]=firefox     )
declare -A PKG_STARSHIP=(  [apt]=starship    [dnf]=starship    [pacman]=starship    )
declare -A PKG_LAZYGIT=(   [apt]=lazygit     [dnf]=lazygit     [pacman]=lazygit     )
declare -A PKG_DUST=(      [apt]=du-dust     [dnf]=du-dust     [pacman]=dust        )
declare -A PKG_WLCLIP=(    [apt]=wl-clipboard [dnf]=wl-clipboard [pacman]=wl-clipboard )
declare -A PKG_XCLIP=(     [apt]=xclip       [dnf]=xclip       [pacman]=xclip       )
declare -A PKG_WEZTERM=(   [apt]=wezterm     [dnf]=wezterm     [pacman]=wezterm     )

# Methods where a tool is NOT a plain repo install on some PM.
# Ubuntu 24.04 repo neovim is 0.9 (< 0.12 that this config's vim.pack needs) ->
# apt is MANUAL (install via bob/appimage/PPA by hand). No bob in the scripts.
declare -A M_NVIM=(     [apt]=script    [dnf]=repo      [pacman]=repo )
declare -A M_STARSHIP=( [apt]=script    [dnf]=script    [pacman]=repo )
declare -A M_LAZYGIT=(  [apt]=script    [dnf]="repo+key" [pacman]=repo )
declare -A M_DUST=(     [apt]=script    [dnf]=script    [pacman]=repo )
declare -A M_WEZTERM=(  [apt]="repo+key" [dnf]="repo+key" [pacman]=repo )
declare -A M_FASTFETCH=( [apt]=script   [dnf]=repo      [pacman]=repo )

# ---------------------------------------------------------------------------
# Dev tools (offered by --dev-tools). Language *packages* from repos are fine
# to script where available; language *version managers* are `runtime` (below).
# ---------------------------------------------------------------------------
declare -A PKG_GIT=(     [apt]=git                           [dnf]=git                        [pacman]=git        )
declare -A PKG_BUILD=(   [apt]=build-essential               [dnf]="gcc gcc-c++ make cmake"   [pacman]="base-devel cmake" )
declare -A PKG_GH=(      [apt]=gh                            [dnf]=gh                         [pacman]=github-cli )
declare -A PKG_PYTHON3=( [apt]="python3 python3-pip python3-venv" [dnf]="python3 python3-pip" [pacman]="python python-pip" )
declare -A PKG_GOLANG=(  [apt]=golang-go                     [dnf]=golang                     [pacman]=go         )
declare -A PKG_NODEJS=(  [apt]=nodejs                        [dnf]=nodejs                     [pacman]=nodejs     )
declare -A PKG_PNPM=(    [apt]=pnpm                          [dnf]=pnpm                       [pacman]=pnpm       )

declare -A M_GH=(     [apt]="repo+key" [dnf]=repo   [pacman]=repo )
declare -A M_GOLANG=( [apt]=script     [dnf]=repo   [pacman]=repo )   # apt path was a raw tarball download
declare -A M_NODEJS=( [apt]=script     [dnf]=repo   [pacman]=repo )   # apt path was NodeSource
# pnpm: Corepack is removed from Node 25+ and pnpm 10 self-manages via the
# "packageManager" field; the get.pnpm.io script path stays manual.
declare -A M_PNPM=(   [apt]=script     [dnf]=repo   [pacman]=repo )

# ---------------------------------------------------------------------------
# Language runtime / version managers — ALWAYS manual (method drifts). Not in
# any SELECTABLE/group; listed so --dry-run can show them and dev-env can echo
# the upstream command under --force-runtimes (never piped straight to a shell).
# ---------------------------------------------------------------------------
declare -A PKG_PYENV=(  [apt]=pyenv   [dnf]=pyenv   [pacman]=pyenv  )
declare -A PKG_NVM=(    [apt]=nvm     [dnf]=nvm     [pacman]=nvm    )
declare -A PKG_SDKMAN=( [apt]=sdkman  [dnf]=sdkman  [pacman]=sdkman )
declare -A PKG_RUST=(   [apt]=rustup  [dnf]=rustup  [pacman]=rustup )
declare -A M_PYENV=(  [apt]=runtime [dnf]=runtime [pacman]=runtime )
declare -A M_NVM=(    [apt]=runtime [dnf]=runtime [pacman]=runtime )
declare -A M_SDKMAN=( [apt]=runtime [dnf]=runtime [pacman]=runtime )
declare -A M_RUST=(   [apt]=runtime [dnf]=runtime [pacman]=runtime )

# ---------------------------------------------------------------------------
# GNOME desktop helpers (offered by --gnome).
# ---------------------------------------------------------------------------
declare -A PKG_GNOME_TWEAKS=( [apt]=gnome-tweaks           [dnf]=gnome-tweaks        [pacman]=gnome-tweaks )
declare -A PKG_GNOME_EXT=(    [apt]=gnome-shell-extensions [dnf]=gnome-extensions-app [pacman]=gnome-shell-extensions )
declare -A PKG_DCONF=(        [apt]=dconf-cli              [dnf]=dconf               [pacman]=dconf )

# ---------------------------------------------------------------------------
# Selection tables (logical id | prompt | default on/off). One definition,
# all distros. Docker/apps/runtimes are deliberately absent — explicit only.
# ---------------------------------------------------------------------------
SELECTABLE=(
  "TMUX|Tmux (terminal multiplexer)|on"
  "ZSH|Zsh (shell)|on"
  "STOW|Stow (dotfile manager)|on"
  "RG|Ripgrep|on"
  "FZF|Fzf (fuzzy finder)|on"
  "FD|Fd (find alternative)|on"
  "BAT|Bat (cat alternative)|on"
  "LSD|Lsd (ls alternative)|on"
  "ZOXIDE|Zoxide|on"
  "UNZIP|Unzip (archive extraction)|on"
  "NVIM|Neovim (0.12+ from distro repo)|on"
  "STARSHIP|Starship (prompt)|on"
  "LAZYGIT|Lazygit|on"
  "WLCLIP|wl-clipboard (Wayland)|on"
  "XCLIP|xclip (X11 fallback)|off"
  "FASTFETCH|Fastfetch|off"
  "DUST|Dust (du alternative)|off"
  "WEZTERM|WezTerm (terminal)|off"
)

# Language/repo dev packages installed by --dev-tools.
DEV_TOOLS_IDS=(GIT BUILD GH PYTHON3 GOLANG NODEJS PNPM)

# GNOME desktop tooling installed by --gnome.
GNOME_IDS=(GNOME_TWEAKS GNOME_EXT DCONF)

# Runtime version managers (echoed under --force-runtimes only).
RUNTIME_IDS=(PYENV NVM SDKMAN RUST)
