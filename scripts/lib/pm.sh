#!/usr/bin/env bash
# pm.sh — package-manager abstraction + the method gate.
#
# Depends on: lib/ui.sh (ui_* helpers) and lib/manifest.sh (PKG_/M_ data).
#
# The gate is the heart of the manual-first policy: install_pkg resolves a
# logical id to its package name + method for the active $PM. Only a plain
# `repo` method is ever installed; every other method prints a MANUAL note and
# is recorded for the end-of-run summary. Nothing here runs a package manager
# under --dry-run.

# Guard against double-sourcing.
[ -n "${_PM_SH_LOADED:-}" ] && return 0
_PM_SH_LOADED=1

# Summary accumulators (consumed by pm_print_summary / install.sh).
SUMMARY_INSTALLED=()
SUMMARY_MANUAL=()
SUMMARY_FAILED=()

# Map a distro id to its package manager, setting the global $PM.
pm_set() {
  case "$1" in
  ubuntu | debian | pop | linuxmint | elementary) PM=apt ;;
  fedora | rhel | centos | rocky | almalinux | nobara) PM=dnf ;;
  arch | archlinux | cachyos | endeavouros | manjaro | garuda) PM=pacman ;;
  *) return 1 ;;
  esac
  export PM
}

# --- idempotent backends (mirror the existing ubuntu/packages.sh style) -----
_apt_install() {
  local p
  for p in "$@"; do
    if dpkg -l 2>/dev/null | grep -q "^ii  $p "; then
      ui_info "$p already installed"
    else
      sudo apt install -y "$p" || return 1
    fi
  done
}

_dnf_install() {
  local p
  for p in "$@"; do
    if rpm -q "$p" >/dev/null 2>&1; then
      ui_info "$p already installed"
    else
      sudo dnf install -y "$p" || return 1
    fi
  done
}

_pacman_install() {
  local p
  for p in "$@"; do
    if pacman -Qi "$p" >/dev/null 2>&1; then
      ui_info "$p already installed"
    else
      sudo pacman -S --noconfirm --needed "$p" || return 1
    fi
  done
}

_pm_backend_install() {
  # $* = one or more package names (already split into args by caller).
  case "${PM:-}" in
  apt) _apt_install "$@" ;;
  dnf) _dnf_install "$@" ;;
  pacman) _pacman_install "$@" ;;
  *)
    ui_err "unknown package manager: '${PM:-unset}'"
    return 1
    ;;
  esac
}

# --- resolution helpers (dynamic PKG_<ID> / M_<ID> lookup) -------------------
_pm_pkg() {
  # echo the resolved package name(s) for logical id $1 on $PM, or nothing.
  local var="PKG_$1"
  declare -p "$var" >/dev/null 2>&1 || return 0
  # shellcheck disable=SC2178
  local -n _ref="$var"
  printf '%s' "${_ref[$PM]:-}"
}

_pm_method() {
  # echo the install method for logical id $1 on $PM (default: repo).
  local var="M_$1"
  if declare -p "$var" >/dev/null 2>&1; then
    # shellcheck disable=SC2178
    local -n _ref="$var"
    printf '%s' "${_ref[$PM]:-repo}"
  else
    printf 'repo'
  fi
}

# --- the gate ---------------------------------------------------------------
# install_pkg <LOGICAL_ID>
install_pkg() {
  local id="$1"
  local pkg method
  pkg="$(_pm_pkg "$id")"
  method="$(_pm_method "$id")"

  if [ -z "$pkg" ]; then
    ui_warn "no package mapping for ${id} on ${PM}; skipping"
    SUMMARY_FAILED+=("${id} (no ${PM} mapping)")
    return 0
  fi

  local auto=0
  [ "$method" = repo ] && auto=1

  # --dry-run: report intent, install nothing, but still populate the summary.
  if [ -n "${DRY_RUN:-}" ]; then
    if [ "$auto" = 1 ]; then
      ui_info "${id}: ${pkg} (${method}) -> auto-install"
      SUMMARY_INSTALLED+=("${pkg}")
    else
      ui_info "${id}: ${pkg} (${method}) -> MANUAL"
      SUMMARY_MANUAL+=("${pkg} (${method})")
    fi
    return 0
  fi

  # Non-repo methods (repo+key / script / vcs+build / flatpak / runtime) are
  # never auto-installed — flag and move on.
  if [ "$auto" != 1 ]; then
    ui_manual "${pkg} (${method}) — install by hand and verify the method hasn't changed; then update this script"
    SUMMARY_MANUAL+=("${pkg} (${method})")
    return 0
  fi

  ui_step "installing ${pkg} (${id})"
  local -a words
  read -r -a words <<<"$pkg"
  if _pm_backend_install "${words[@]}"; then
    SUMMARY_INSTALLED+=("${pkg}")
  else
    ui_err "failed to install ${pkg}"
    SUMMARY_FAILED+=("${pkg}")
  fi
}

# install_group <LOGICAL_ID...>
install_group() {
  local id
  for id in "$@"; do
    install_pkg "$id"
  done
}

# --- end-of-run summary -----------------------------------------------------
pm_print_summary() {
  local verb="Installed"
  [ -n "${DRY_RUN:-}" ] && verb="Would install"

  local -a lines=()
  lines+=("${verb}: ${#SUMMARY_INSTALLED[@]}    Manual: ${#SUMMARY_MANUAL[@]}    Failed: ${#SUMMARY_FAILED[@]}")

  if [ "${#SUMMARY_MANUAL[@]}" -gt 0 ]; then
    lines+=("")
    lines+=("Do these by hand (verify the method, then update the script):")
    local m
    for m in "${SUMMARY_MANUAL[@]}"; do lines+=("  - ${m}"); done
  fi
  if [ "${#SUMMARY_FAILED[@]}" -gt 0 ]; then
    lines+=("")
    lines+=("Failed:")
    local f
    for f in "${SUMMARY_FAILED[@]}"; do lines+=("  - ${f}"); done
  fi

  ui_box "$C_CYAN" "Summary" "${lines[@]}"
}
