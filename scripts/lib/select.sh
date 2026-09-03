#!/usr/bin/env bash
# select.sh — one confirm-driven selection UI over the manifest, shared by all
# distros. Reads SELECTABLE (from manifest.sh); populates the global CHOSEN_IDS
# array with the logical ids the user picked.

# Guard against double-sourcing.
[ -n "${_SELECT_SH_LOADED:-}" ] && return 0
_SELECT_SH_LOADED=1

# Default-aware yes/no prompt (utils/confirm.sh stays default-less by design).
_confirm_default() {
  local msg="$1" def="$2" ans hint
  if [ "$def" = on ]; then hint="Y/n"; else hint="y/N"; fi
  printf '%b%s (%s): %b' "${C_YELLOW}" "$msg" "$hint" "${C_RESET}"
  read -r ans
  ans="$(printf '%s' "$ans" | tr '[:upper:]' '[:lower:]')"
  if [ -z "$ans" ]; then
    [ "$def" = on ]
  else
    [ "$ans" = y ] || [ "$ans" = yes ]
  fi
}

# select_from <ARRAY_NAME> — render a selection table (rows "ID|prompt|default")
# from the named array into CHOSEN_IDS. Defaults to SELECTABLE.
select_from() {
  local arr_name="${1:-SELECTABLE}"
  # shellcheck disable=SC2178
  local -n _rows="$arr_name"
  CHOSEN_IDS=()
  local row id prompt def
  for row in "${_rows[@]}"; do
    IFS='|' read -r id prompt def <<<"$row"
    [ -z "$def" ] && def=on
    if _confirm_default "  - ${prompt}?" "$def"; then
      CHOSEN_IDS+=("$id")
    fi
  done
}

# Convenience: run the standard system-packages selection.
select_tools() {
  ui_section "Select packages to install"
  select_from SELECTABLE
}
