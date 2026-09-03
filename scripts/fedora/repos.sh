#!/usr/bin/env bash
# repos.sh — system-enabling repos that dev tooling actually needs.
#
# Requires dnf5 (Fedora 41+): `config-manager addrepo/setopt`, not the dnf4
# `--add-repo`/`--enable` forms. No dnf4 fallback on purpose.
#
# App-store style repos (VS Code, Chrome, Brave) do NOT belong here — they
# live in fedora/apps.sh behind --apps.

# Guard against double-sourcing.
[ -n "${_FEDORA_REPOS_SH_LOADED:-}" ] && return 0
_FEDORA_REPOS_SH_LOADED=1

# _fedora_run <cmd...> — run, or just print under --dry-run.
_fedora_run() {
  if [ -n "${DRY_RUN:-}" ]; then
    ui_info "dry-run: $*"
  else
    "$@"
  fi
}

_fedora_add_docker_repo() {
  if [ -f /etc/yum.repos.d/docker-ce.repo ]; then
    ui_info "docker-ce repo already present"
    return 0
  fi
  ui_step "adding Docker CE repo (dnf5 addrepo)"
  _fedora_run sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
}

setup_fedora_repos() {
  ui_section "System repos (RPM Fusion, openh264, Flathub)"

  if confirm "Enable RPM Fusion (free + nonfree)?"; then
    if [ -f /etc/yum.repos.d/rpmfusion-free.repo ] && [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]; then
      ui_info "RPM Fusion repos already present"
    else
      local rel
      rel="$(rpm -E %fedora)"
      _fedora_run sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${rel}.noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${rel}.noarch.rpm"
    fi
  fi

  if confirm "Enable fedora-cisco-openh264?"; then
    _fedora_run sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
  fi

  if confirm "Add Flathub flatpak remote?"; then
    if command -v flatpak >/dev/null 2>&1; then
      _fedora_run flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
      ui_manual "flatpak is not installed — install it first, then re-run"
    fi
  fi

  ui_ok "repo setup done"
}
