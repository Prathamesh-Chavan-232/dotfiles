#!/usr/bin/env bash
# plugins.sh — plugin managers for tmux (TPM) and zsh (Zap). Distro-agnostic.

# Guard against double-sourcing.
[ -n "${_COMMON_PLUGINS_SH_LOADED:-}" ] && return 0
_COMMON_PLUGINS_SH_LOADED=1

install_plugin_managers() {
  ui_section "Plugin managers (TPM, Zap)"

  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [ -d "$tpm_dir" ] && [ "$(ls -A "$tpm_dir")" ]; then
    ui_info "Tmux Plugin Manager (TPM) is already installed at $tpm_dir"
  elif [ -n "${DRY_RUN:-}" ]; then
    ui_info "dry-run: git clone https://github.com/tmux-plugins/tpm $tpm_dir"
  else
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    ui_ok "TPM installed at $tpm_dir"
  fi

  if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zap" ]; then
    ui_info "Zsh plugin manager (Zap) is already installed"
  elif [ -n "${DRY_RUN:-}" ]; then
    ui_info "dry-run: zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1"
  elif ! command -v zsh >/dev/null 2>&1; then
    ui_manual "zap needs zsh — install zsh first, then re-run --plugins"
  else
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
    ui_ok "Zap installed"
  fi
}
