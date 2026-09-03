#!/usr/bin/env bash
# packages.sh — Fedora-only extras beyond the shared manifest.
#
# Everyday CLI tools come from lib/manifest.sh + lib/pm.sh; this file only
# holds package groups that make no sense on other distros.

# Guard against double-sourcing.
[ -n "${_FEDORA_PACKAGES_SH_LOADED:-}" ] && return 0
_FEDORA_PACKAGES_SH_LOADED=1

# X11/bspwm stack for a gh0stzk-style rice. The rice itself is a manual,
# separate-session setup — this only installs the plain-repo base packages.
install_bspwm_stack() {
  ui_section "bspwm/X11 stack (base packages only)"
  ui_warn "the rice itself (gh0stzk etc.) is a manual, separate-session setup"

  if ! confirm "Install the bspwm/X11 base stack?"; then
    return 0
  fi

  local pkgs=(
    @base-x bspwm sxhkd polybar picom rofi-wayland dunst
    feh jgmenu xsettingsd playerctl xdotool maim
  )

  if [ -n "${DRY_RUN:-}" ]; then
    ui_info "dry-run: sudo dnf install -y ${pkgs[*]}"
  else
    _dnf_install "${pkgs[@]}" || ui_err "bspwm stack install had failures"
  fi

  ui_manual "eww (vcs+build) — needs cargo or a COPR; build by hand"
  ui_manual "clipcat (vcs+build) — needs cargo or a COPR; build by hand"
}
