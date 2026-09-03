#!/usr/bin/env bash
# apps.sh — optional GUI apps (Fedora). Reachable ONLY via --apps / the menu's
# "optional apps" entry — never part of setup or any batch flow.
#
# These are repo+key / flatpak methods, so on a fresh system they stay manual;
# this scripted path exists purely for throwaway-VM re-provisioning.

# Guard against double-sourcing.
[ -n "${_FEDORA_APPS_SH_LOADED:-}" ] && return 0
_FEDORA_APPS_SH_LOADED=1

install_apps() {
  ui_section "Optional apps (opt-in only)"
  ui_warn "these add third-party repos/flatpaks — do it by hand on a fresh system"

  if confirm "Install Firefox (plain repo package)?"; then
    install_pkg FIREFOX
  fi

  if confirm "Install VS Code (Microsoft repo+key)?"; then
    if [ -n "${DRY_RUN:-}" ]; then
      ui_info "dry-run: sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc"
      ui_info "dry-run: write /etc/yum.repos.d/vscode.repo + sudo dnf install -y code"
      SUMMARY_INSTALLED+=("code (repo+key)")
    elif command -v code >/dev/null 2>&1; then
      ui_info "VS Code is already installed"
    else
      sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
      printf '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\n' |
        sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
      if sudo dnf install -y code; then
        SUMMARY_INSTALLED+=("code (repo+key)")
      else
        SUMMARY_FAILED+=("code")
      fi
    fi
  fi

  if confirm "Install Google Chrome (google-chrome repo)?"; then
    if [ -n "${DRY_RUN:-}" ]; then
      ui_info "dry-run: sudo dnf config-manager setopt google-chrome.enabled=1"
      ui_info "dry-run: sudo dnf install -y google-chrome-stable"
      SUMMARY_INSTALLED+=("google-chrome-stable (repo+key)")
    elif command -v google-chrome >/dev/null 2>&1; then
      ui_info "Google Chrome is already installed"
    else
      # Fedora ships a disabled google-chrome repo (fedora-workstation-repositories).
      sudo dnf install -y fedora-workstation-repositories
      sudo dnf config-manager setopt google-chrome.enabled=1
      if sudo dnf install -y google-chrome-stable; then
        SUMMARY_INSTALLED+=("google-chrome-stable (repo+key)")
      else
        SUMMARY_FAILED+=("google-chrome-stable")
      fi
    fi
  fi

  if confirm "Install Brave (Brave repo+key)?"; then
    if [ -n "${DRY_RUN:-}" ]; then
      ui_info "dry-run: sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo"
      ui_info "dry-run: sudo dnf install -y brave-browser"
      SUMMARY_INSTALLED+=("brave-browser (repo+key)")
    elif command -v brave-browser >/dev/null 2>&1; then
      ui_info "Brave is already installed"
    else
      sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
      if sudo dnf install -y brave-browser; then
        SUMMARY_INSTALLED+=("brave-browser (repo+key)")
      else
        SUMMARY_FAILED+=("brave-browser")
      fi
    fi
  fi

  if confirm "Install Spotify (flatpak, needs Flathub)?"; then
    if [ -n "${DRY_RUN:-}" ]; then
      ui_info "dry-run: flatpak install -y flathub com.spotify.Client"
      SUMMARY_INSTALLED+=("com.spotify.Client (flatpak)")
    elif ! command -v flatpak >/dev/null 2>&1; then
      ui_manual "flatpak not installed — enable Flathub via --repos first"
    elif flatpak install -y flathub com.spotify.Client; then
      SUMMARY_INSTALLED+=("com.spotify.Client (flatpak)")
    else
      SUMMARY_FAILED+=("com.spotify.Client")
    fi
  fi
}
