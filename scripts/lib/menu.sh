#!/usr/bin/env bash
# menu.sh — no-arg interactive looping menu ("install things as I need them").
#
# Prints a numbered action list, runs the chosen action, then loops until 'q'.
# There is deliberately NO "all"/"everything" entry — selection is always
# explicit. The action_* handlers are defined in install.sh (both the arg loop
# and this menu dispatch through them), so they resolve at call time.

# Guard against double-sourcing.
[ -n "${_MENU_SH_LOADED:-}" ] && return 0
_MENU_SH_LOADED=1

run_menu() {
  local choice
  while true; do
    ui_section "dotfiles installer — ${DISTRO:-unknown} (${PM:-?}) — pick an action"
    _ui_emit "  1) System packages (CLI tools)"
    _ui_emit "  2) Dev tools (repo language packages)"
    _ui_emit "  3) Link dotfiles"
    _ui_emit "  4) Plugin managers (TPM, Zap)"
    _ui_emit "  5) GNOME tools"
    _ui_emit "  6) Set Zsh as default shell"
    _ui_emit "  7) System repos      ${C_DIM}(RPM Fusion, Flathub — Fedora only)${C_RESET}"
    _ui_emit "  8) Docker            ${C_DIM}(explicit opt-in)${C_RESET}"
    _ui_emit "  9) Optional apps     ${C_DIM}(browsers, VS Code, Spotify — opt-in)${C_RESET}"
    _ui_emit " 10) Hyprland rice     ${C_DIM}(upstream handoff)${C_RESET}"
    _ui_emit " 11) bspwm/X11 stack   ${C_DIM}(Fedora only)${C_RESET}"
    _ui_emit "  q) Quit"
    printf '%bchoice: %b' "${C_BOLD}" "${C_RESET}"
    read -r choice
    case "$choice" in
    1) action_system_packages ;;
    2) action_dev_tools ;;
    3) action_dotfiles ;;
    4) action_plugins ;;
    5) action_gnome ;;
    6) action_shell ;;
    7) action_repos ;;
    8) action_docker ;;
    9) action_apps ;;
    10) action_hyprland ;;
    11) action_bspwm_stack ;;
    q | Q | quit | exit) break ;;
    "") ;;
    *) ui_warn "unknown choice: ${choice}" ;;
    esac
  done
}
