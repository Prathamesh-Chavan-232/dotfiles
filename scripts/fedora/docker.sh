#!/usr/bin/env bash
# docker.sh — Docker Engine on Fedora (explicit opt-in scripted path).
#
# Docker is `repo+key` method, so it is never part of any default/batch flow;
# this function only runs via --docker / the menu, behind its own confirm.
# Repo add uses dnf5 `config-manager addrepo` (Fedora 41+).

# Guard against double-sourcing.
[ -n "${_FEDORA_DOCKER_SH_LOADED:-}" ] && return 0
_FEDORA_DOCKER_SH_LOADED=1

install_docker() {
  ui_section "Docker Engine"

  if command -v docker >/dev/null 2>&1 && [ -z "${DRY_RUN:-}" ]; then
    ui_info "docker is already installed"
    return 0
  fi

  ui_warn "this adds the third-party Docker CE repo (repo+key method)"
  ui_warn "on a fresh system do this by hand first and verify the method"
  if ! confirm "Install Docker Engine from the Docker CE repo?"; then
    SUMMARY_MANUAL+=("docker (repo+key)")
    return 0
  fi

  _fedora_add_docker_repo || {
    ui_err "failed to add Docker CE repo"
    SUMMARY_FAILED+=("docker (repo add)")
    return 0
  }

  local pkgs=(docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin)
  if [ -n "${DRY_RUN:-}" ]; then
    ui_info "dry-run: sudo dnf install -y ${pkgs[*]}"
    ui_info "dry-run: sudo systemctl enable --now docker"
    ui_info "dry-run: sudo usermod -aG docker $USER"
    SUMMARY_INSTALLED+=("docker-ce (+cli, containerd, buildx, compose)")
    return 0
  fi

  if ! sudo dnf install -y "${pkgs[@]}"; then
    ui_err "docker install failed"
    SUMMARY_FAILED+=("docker-ce")
    return 0
  fi

  ui_step "enabling docker service"
  sudo systemctl enable --now docker

  if confirm "Add $USER to the docker group (non-root access)?"; then
    sudo groupadd docker 2>/dev/null || true
    sudo usermod -aG docker "$USER"
    ui_warn "log out and back in (or reboot) for docker group membership to apply"
  fi

  SUMMARY_INSTALLED+=("docker-ce (+cli, containerd, buildx, compose)")
  ui_ok "Docker Engine installed"
}
