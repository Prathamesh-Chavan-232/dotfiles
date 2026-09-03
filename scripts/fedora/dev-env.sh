#!/usr/bin/env bash
# dev-env.sh — Fedora development tooling.
#
# Only plain-repo language packages are scripted (git, gcc, gh, python3,
# golang, nodejs, pnpm — all `repo` on dnf, including pnpm: Corepack is
# removed from Node 25+ and pnpm 10 self-manages via "packageManager").
# Language *version managers* are `runtime` method: never installed here.
# On a fresh system install them by hand, verify the upstream method still
# matches, then update the manifest — that's the whole point.

# Guard against double-sourcing.
[ -n "${_FEDORA_DEVENV_SH_LOADED:-}" ] && return 0
_FEDORA_DEVENV_SH_LOADED=1

install_dev_tools() {
  ui_section "Dev tools (repo language packages)"

  if confirm "Install repo dev packages (git, build tools, gh, python3, go, node, pnpm)?"; then
    install_group "${DEV_TOOLS_IDS[@]}"
  fi

  print_runtime_notes
}

# Runtime version managers are refused by default. Under --force-runtimes the
# upstream commands are ECHOED for the owner to eyeball — never executed, and
# never piped straight into a shell by this script.
print_runtime_notes() {
  local id
  for id in "${RUNTIME_IDS[@]}"; do
    ui_manual "$(_pm_pkg "$id") (runtime) — install by hand and verify the method hasn't changed; then update this script"
    SUMMARY_MANUAL+=("$(_pm_pkg "$id") (runtime)")
  done

  if [ -n "${FORCE_RUNTIMES:-}" ]; then
    ui_warn "--force-runtimes: upstream commands (verify before running — NOT executed):"
    ui_info '  pyenv : curl -fsSL https://pyenv.run | bash'
    ui_info '  nvm   : curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash'
    ui_info '  sdkman: curl -s "https://get.sdkman.io" | bash'
    ui_info '  rustup: curl --proto '"'"'=https'"'"' --tlsv1.2 -sSf https://sh.rustup.rs | sh'
  else
    ui_info "(--force-runtimes echoes the upstream install commands for VM use)"
  fi
}
