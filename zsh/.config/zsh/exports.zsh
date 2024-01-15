#!/bin/sh
HISTFILE=~/.cache/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# export XDG_CURRENT_DESKTOP="Wayland"
#export PATH="$PATH:./node_modules/.bin"

export GPG_TTY=$TTY
path=(~/bin $path)

# pnpm
export PNPM_HOME="/home/falconcodes/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# flutter
export PATH="$PATH:/home/falconcodes/flutter/bin"

eval "$(zoxide init zsh)"
eval "`pip completion --zsh`"

