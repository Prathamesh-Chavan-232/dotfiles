#!/usr/bin/env bash
# ui.sh — centralized presentation layer shared by every distro/module.
#
# Supersedes utils/loggers.sh: color palette, Nerd-Font glyphs (ASCII fallback),
# framed boxes, the launch banner, and — critically — ANSI-safe logging so
# install_log.txt never receives escape codes.
#
# Capability rules (hard requirements):
#   * color/glyphs auto-disable under $NO_COLOR or when stdout is not a TTY
#   * colored text goes to the terminal; an ANSI-stripped copy goes to the log
#   * glyphs degrade ✓→✗⚠ℹ➜  ->  [ok] [x] [!] [i] [>]

# Guard against double-sourcing (files are always sourced, never executed).
[ -n "${_UI_SH_LOADED:-}" ] && return 0
_UI_SH_LOADED=1

# --- capability detection (computed once at source time) --------------------
if [ -t 1 ]; then _UI_TTY=1; else _UI_TTY=0; fi

if [ -z "${NO_COLOR:-}" ] && [ "$_UI_TTY" = 1 ]; then
  UI_COLOR=1
else
  UI_COLOR=0
fi

# Glyph mode: honour an explicit UI_GLYPHS override, else nerd only on a
# UTF-8 TTY, ascii otherwise.
if [ -z "${UI_GLYPHS:-}" ]; then
  case "${LC_ALL:-${LC_CTYPE:-${LANG:-}}}" in
  *UTF-8* | *utf-8* | *utf8* | *UTF8*)
    [ "$_UI_TTY" = 1 ] && UI_GLYPHS=nerd || UI_GLYPHS=ascii
    ;;
  *) UI_GLYPHS=ascii ;;
  esac
fi

# --- palette ----------------------------------------------------------------
if [ "$UI_COLOR" = 1 ]; then
  C_RESET=$'\e[0m'
  C_BOLD=$'\e[1m'
  C_DIM=$'\e[2m'
  C_RED=$'\e[31m'
  C_GREEN=$'\e[32m'
  C_YELLOW=$'\e[33m'
  C_BLUE=$'\e[34m'
  C_MAGENTA=$'\e[35m'
  C_CYAN=$'\e[36m'
else
  C_RESET='' C_BOLD='' C_DIM='' C_RED='' C_GREEN='' C_YELLOW='' C_BLUE='' C_MAGENTA='' C_CYAN=''
fi

# --- glyphs -----------------------------------------------------------------
if [ "$UI_GLYPHS" = nerd ]; then
  G_OK="✓" G_STEP="➜" G_ERR="✗" G_WARN="⚠" G_INFO="ℹ"
else
  G_OK="[ok]" G_STEP="[>]" G_ERR="[x]" G_WARN="[!]" G_INFO="[i]"
fi

# --- log-safe emit ----------------------------------------------------------
# INSTALL_LOG (any non-empty value) enables logging to $INSTALL_LOG_FILE
# (default install_log.txt). The log copy is always ANSI-stripped.
_ui_strip_ansi() {
  sed "s/$(printf '\033')\[[0-9;]*m//g"
}

_ui_emit() {
  printf '%s\n' "$*"
  if [ -n "${INSTALL_LOG:-}" ]; then
    printf '%s\n' "$*" | _ui_strip_ansi >>"${INSTALL_LOG_FILE:-install_log.txt}"
  fi
}

# --- geometry helpers -------------------------------------------------------
_ui_width() {
  local w="${COLUMNS:-}"
  [ -z "$w" ] && w="$(tput cols 2>/dev/null || echo 64)"
  case "$w" in
  '' | *[!0-9]*) w=64 ;;
  esac
  [ "$w" -gt 80 ] && w=80
  [ "$w" -lt 24 ] && w=24
  printf '%s' "$w"
}

_ui_repeat() {
  # _ui_repeat <char> <count> — multibyte-safe repeat.
  local ch="$1" n="$2" out='' i=0
  while [ "$i" -lt "$n" ]; do
    out="${out}${ch}"
    i=$((i + 1))
  done
  printf '%s' "$out"
}

# --- primitives -------------------------------------------------------------
ui_section() {
  local text="$1" ch='─' w
  [ "$UI_GLYPHS" = ascii ] && ch='-'
  w="$(_ui_width)"
  _ui_emit ""
  _ui_emit "${C_BOLD}${C_CYAN}$(_ui_repeat "$ch" "$w")${C_RESET}"
  _ui_emit "${C_BOLD}${C_CYAN}  ${text}${C_RESET}"
  _ui_emit "${C_BOLD}${C_CYAN}$(_ui_repeat "$ch" "$w")${C_RESET}"
}

ui_step() { _ui_emit "${C_BLUE}${G_STEP}${C_RESET} $*"; }
ui_ok() { _ui_emit "${C_GREEN}${G_OK}${C_RESET} $*"; }
ui_warn() { _ui_emit "${C_YELLOW}${G_WARN}${C_RESET} $*"; }
ui_err() { _ui_emit "${C_RED}${G_ERR}${C_RESET} $*"; }
ui_info() { _ui_emit "${C_DIM}${G_INFO} $*${C_RESET}"; }

# The standardized MANUAL-skip line (yellow) printed by the method gate.
ui_manual() { _ui_emit "${C_YELLOW}${G_WARN} MANUAL:${C_RESET} $*"; }

# Loud, double-bordered framed box (used for the policy warning + summary).
# Usage: ui_box <color-var> "line 1" "line 2" ...
ui_box() {
  local color="$1"
  shift
  local tl tr bl br h v
  if [ "$UI_GLYPHS" = ascii ]; then
    tl='+' tr='+' bl='+' br='+' h='=' v='|'
  else
    tl='╔' tr='╗' bl='╚' br='╝' h='═' v='║'
  fi

  local maxw=0 line
  for line in "$@"; do
    [ "${#line}" -gt "$maxw" ] && maxw="${#line}"
  done
  local inner=$((maxw + 2))
  local border
  border="$(_ui_repeat "$h" "$inner")"

  _ui_emit "${color}${tl}${border}${tr}${C_RESET}"
  for line in "$@"; do
    local pad=$((maxw - ${#line}))
    _ui_emit "${color}${v}${C_RESET} ${line}$(_ui_repeat ' ' "$pad") ${color}${v}${C_RESET}"
  done
  _ui_emit "${color}${bl}${border}${br}${C_RESET}"
}

# --- launch banner ----------------------------------------------------------
# Static ANSI-Shadow "DOTFILES" (font matches nvim/lua/plugins/alpha.lua). This
# is the guaranteed fallback; a dynamic per-distro line is layered on top when
# figlet/toilet is available. Banner is intentionally quieter than the policy box.
_ui_banner_static() {
  _ui_emit "${C_CYAN}██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗${C_RESET}"
  _ui_emit "${C_CYAN}██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝${C_RESET}"
  _ui_emit "${C_CYAN}██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗${C_RESET}"
  _ui_emit "${C_CYAN}██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║${C_RESET}"
  _ui_emit "${C_CYAN}██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║${C_RESET}"
  _ui_emit "${C_CYAN}╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝${C_RESET}"
}

ui_banner() {
  local distro="${1:-}"
  # Prefer a dynamic distro-aware render if the tools exist (optional flair).
  if [ -n "$distro" ] && command -v figlet >/dev/null 2>&1; then
    local art
    art="$(figlet -f "ANSI Shadow" "$distro" 2>/dev/null || figlet "$distro" 2>/dev/null || true)"
    if [ -n "$art" ]; then
      if command -v lolcat >/dev/null 2>&1 && [ "$UI_COLOR" = 1 ]; then
        printf '%s\n' "$art" | lolcat 2>/dev/null || _ui_emit "${C_MAGENTA}${art}${C_RESET}"
      else
        while IFS= read -r line; do _ui_emit "${C_MAGENTA}${line}${C_RESET}"; done <<<"$art"
      fi
      _ui_banner_static
      return 0
    fi
  fi
  _ui_banner_static
  [ -n "$distro" ] && ui_info "target: ${distro}"
}
