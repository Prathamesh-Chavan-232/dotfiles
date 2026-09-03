#!/usr/bin/env bash
# install.sh — unified dotfiles/environment installer (Fedora-first).
#
# MANUAL-FIRST POLICY: this script is NOT a fresh-install autopilot. Fresh
# systems are set up by hand so upstream method drift gets noticed; the script
# only re-provisions throwaway users/VMs after being validated against that
# manual install. Only plain distro-repo packages ever auto-install — every
# other method (repo+key, curl|bash, runtimes, flatpak) is flagged MANUAL.
#
# There is deliberately NO --all and no run-everything path.
#
# Usage:
#   ./scripts/install.sh                 # interactive looping menu
#   ./scripts/install.sh --dry-run --system-packages
#   ./scripts/install.sh --help

# Sourced files are checked individually; don't follow them here.
# shellcheck disable=SC1091

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
export DOTFILES_DIR

# --- shared libraries (distro backend is sourced after detection) -----------
source "$SCRIPT_DIR/lib/ui.sh"
source "$SCRIPT_DIR/utils/loggers.sh"
source "$SCRIPT_DIR/utils/confirm.sh"
source "$SCRIPT_DIR/utils/system-link.sh"
source "$SCRIPT_DIR/lib/manifest.sh"
source "$SCRIPT_DIR/lib/pm.sh"
source "$SCRIPT_DIR/lib/select.sh"
source "$SCRIPT_DIR/lib/menu.sh"

source "$SCRIPT_DIR/common/link-dotfiles.sh"
source "$SCRIPT_DIR/common/gnome-settings.sh"
source "$SCRIPT_DIR/common/settings.sh"
source "$SCRIPT_DIR/common/fin.sh"
source "$SCRIPT_DIR/common/github-keys.sh"
source "$SCRIPT_DIR/common/plugins.sh"

# --- global flags (pre-scanned so they work in any position) ----------------
DRY_RUN="${DRY_RUN:-}"
FORCE_RUNTIMES="${FORCE_RUNTIMES:-}"
DISTRO_OVERRIDE=""
ACTIONS=()

while [ $# -gt 0 ]; do
  case "$1" in
  --dry-run) DRY_RUN=1 ;;
  --force-runtimes) FORCE_RUNTIMES=1 ;;
  --distro)
    shift
    if [ -z "${1:-}" ]; then
      ui_err "--distro requires a value (ubuntu|fedora|arch)"
      exit 1
    fi
    DISTRO_OVERRIDE="$1"
    ;;
  *) ACTIONS+=("$1") ;;
  esac
  shift
done
export DRY_RUN FORCE_RUNTIMES

# --- distro detection -------------------------------------------------------
if [ -n "$DISTRO_OVERRIDE" ]; then
  DISTRO="$DISTRO_OVERRIDE"
elif [ -r /etc/os-release ]; then
  DISTRO="$(. /etc/os-release && printf '%s' "$ID")"
else
  DISTRO=""
fi

if ! pm_set "$DISTRO"; then
  ui_err "unsupported or undetected distro: '${DISTRO:-?}' (override with --distro <ubuntu|fedora|arch>)"
  exit 1
fi
export DISTRO

# Fedora backend (the only wired backend; ubuntu/*.sh are legacy reference and
# are intentionally NOT sourced — see CLAUDE.md).
if [ "$PM" = dnf ]; then
  source "$SCRIPT_DIR/fedora/repos.sh"
  source "$SCRIPT_DIR/fedora/packages.sh"
  source "$SCRIPT_DIR/fedora/dev-env.sh"
  source "$SCRIPT_DIR/fedora/docker.sh"
  source "$SCRIPT_DIR/fedora/apps.sh"
fi

# --- policy banner (every invocation, including --help) ---------------------
print_policy_box() {
  ui_box "$C_YELLOW" \
    "NOTE: This script is NOT for setting up a fresh system." \
    "On a fresh install, install packages MANUALLY — especially" \
    "language runtimes (python, node, java, rust, go) and anything" \
    "needing a third-party repo/key. Upstream methods change; doing" \
    "it by hand is how you catch that, then update this script." \
    "" \
    "This script is only for quickly re-provisioning throwaway" \
    "users / VMs AFTER it has been validated on that fresh install."
}

show_help() {
  cat <<EOF
Dotfiles environment installer — ${DISTRO} (${PM})

Usage:
    $0 [GLOBAL FLAGS] [ACTIONS...]
    $0                  # no args: interactive looping menu (no "all" option)

Global flags:
    --dry-run           Print resolved packages, methods and commands; run nothing
    --force-runtimes    Echo (never execute) upstream runtime install commands
    --distro <id>       Override distro detection (ubuntu|fedora|arch) — testing

Actions (each runs exactly one thing; combine freely):
    -h, --help          Show this help
    --update            Update system packages
    --system-packages   Select + install CLI tools (plain repo packages only)
    --dev-tools         Repo dev packages (git, gcc, gh, python3, go, node, pnpm)
    --repos             Enable system repos (RPM Fusion, openh264, Flathub) [fedora]
    --docker            Docker Engine (explicit opt-in; adds third-party repo) [fedora]
    --apps              Optional apps: VS Code/Chrome/Brave/Spotify (opt-in) [fedora]
    --dotfiles          Link dotfiles via stow
    --plugins           Plugin managers (TPM, Zap)
    --gnome             GNOME tweaks/extensions tooling
    --gnome-settings    Load GNOME settings from dconf dump
    --github-keys       Set up GitHub SSH keys
    --shell             Set Zsh as the default shell
    --bspwm-stack       bspwm/X11 base packages [fedora]

There is no --all: selection is always explicit (manual-first policy above).
EOF
}

# --- action handlers (shared by the arg loop and lib/menu.sh) ---------------
_fedora_only() {
  ui_manual "$1 is not implemented for ${DISTRO} — install manually"
}

action_update() {
  if [ -n "$DRY_RUN" ]; then
    ui_info "dry-run: system update via ${PM}"
    return 0
  fi
  confirm "Update system packages?" || return 0
  case "$PM" in
  apt) sudo apt update && sudo apt upgrade -y ;;
  dnf) sudo dnf upgrade --refresh ;;
  pacman) sudo pacman -Syu ;;
  esac
}

action_system_packages() {
  select_tools
  install_group "${CHOSEN_IDS[@]}"
}

action_dev_tools() {
  if declare -F install_dev_tools >/dev/null; then
    install_dev_tools # fedora backend (includes runtime MANUAL notes)
  else
    ui_section "Dev tools (repo language packages)"
    if confirm "Install repo dev packages (git, build tools, gh, python3, go, node, pnpm)?"; then
      install_group "${DEV_TOOLS_IDS[@]}"
    fi
    local id
    for id in "${RUNTIME_IDS[@]}"; do
      ui_manual "$(_pm_pkg "$id") (runtime) — install by hand and verify the method hasn't changed; then update this script"
      SUMMARY_MANUAL+=("$(_pm_pkg "$id") (runtime)")
    done
  fi
}

action_gnome() {
  ui_section "GNOME tooling"
  if confirm "Install GNOME tweaks/extensions/dconf packages?"; then
    install_group "${GNOME_IDS[@]}"
  fi
  ui_info "Recommended extensions (install via extensions.gnome.org):"
  ui_info "  Just Perfection, User Themes, No Overview at Startup,"
  ui_info "  Forge, Blur My Shell, Media Controls"
}

action_dotfiles() { link_dotfiles; }
action_plugins() { install_plugin_managers; }
action_shell() { setup_zsh; }
action_gnome_settings() { load_gnome_settings; }
action_github_keys() { setup_github_keys; }

action_repos() {
  if [ "$PM" = dnf ]; then setup_fedora_repos; else _fedora_only "repo setup"; fi
}
action_docker() {
  if [ "$PM" = dnf ]; then install_docker; else _fedora_only "docker"; fi
}
action_apps() {
  if [ "$PM" = dnf ]; then install_apps; else _fedora_only "optional apps"; fi
}
action_bspwm_stack() {
  if [ "$PM" = dnf ]; then install_bspwm_stack; else _fedora_only "bspwm stack"; fi
}

# --- dispatch ---------------------------------------------------------------
dispatch() {
  case "$1" in
  -h | --help) show_help ;;
  --update) action_update ;;
  --system-packages) action_system_packages ;;
  --dev-tools) action_dev_tools ;;
  --repos) action_repos ;;
  --docker) action_docker ;;
  --apps) action_apps ;;
  --dotfiles) action_dotfiles ;;
  --plugins) action_plugins ;;
  --gnome) action_gnome ;;
  --gnome-settings) action_gnome_settings ;;
  --github-keys) action_github_keys ;;
  --shell) action_shell ;;
  --bspwm-stack) action_bspwm_stack ;;
  *)
    ui_err "Unknown option: $1"
    ui_info "Run '$0 --help' for usage"
    exit 1
    ;;
  esac
}

_maybe_summary() {
  if [ "${#SUMMARY_INSTALLED[@]}" -gt 0 ] || [ "${#SUMMARY_MANUAL[@]}" -gt 0 ] || [ "${#SUMMARY_FAILED[@]}" -gt 0 ]; then
    pm_print_summary
  fi
}

main() {
  ui_banner "$DISTRO"
  print_policy_box
  [ -n "$DRY_RUN" ] && ui_warn "dry-run: nothing will be installed"

  if [ "${#ACTIONS[@]}" -eq 0 ]; then
    run_menu
  else
    local a
    for a in "${ACTIONS[@]}"; do
      dispatch "$a"
    done
  fi

  _maybe_summary
}

main
