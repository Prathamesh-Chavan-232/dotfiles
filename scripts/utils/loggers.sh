#!/usr/bin/env bash
# loggers.sh — thin back-compat shim over lib/ui.sh.
#
# ui.sh is the real presentation layer. These aliases keep existing callers
# (common/*.sh, utils/confirm.sh) working unchanged: the legacy $RED/$GREEN/
# $YELLOW/$LIGHT_PURPLE/$NC vars and print_header/print_subheader/print_log —
# now routed through the log-safe emitter so install_log.txt stays ANSI-free.

# The legacy vars are consumed by files sourced later (common/*.sh, confirm.sh).
# shellcheck disable=SC2034

_loggers_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/ui.sh disable=SC1091
[ -z "${_UI_SH_LOADED:-}" ] && source "$_loggers_dir/../lib/ui.sh"

# Legacy colour variable names (now real escape sequences, empty when disabled).
RED="$C_RED"
GREEN="$C_GREEN"
YELLOW="$C_YELLOW"
LIGHT_PURPLE="$C_MAGENTA"
NC="$C_RESET"

print_header() {
  local color="$1"
  _ui_emit ""
  _ui_emit "${color}==== $2 [$(date +'%Y-%m-%d %H:%M:%S')] ====${NC}"
  _ui_emit ""
}

print_subheader() {
  local color="$1"
  _ui_emit "${color}$2${NC}"
}

print_log() {
  local color="$1"
  _ui_emit ""
  _ui_emit "${color}$2                              [$(date +'%Y-%m-%d %H:%M:%S')]${NC}"
}
