#  ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗
#  ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦
#  ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝

# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Start tmux if not already in tmux.
# zstyle ':z4h:' start-tmux command tmux -u new -A -D -t zsh

# Whether to move prompt to the bottom when zsh starts and on Ctrl+L.
zstyle ':z4h:' prompt-at-bottom 'no'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'yes'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)
export PATH="$HOME/.tmuxifier/bin:$PATH"
# pnpm
export PNPM_HOME="/home/falconcodes/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu


# EDITOR
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘

# Maintenance
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias maintenimiento="yay -Sc && sudo pacman -Scc"
alias purga="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
alias update="sudo pacman -Syu --nocombinedupgrade"

# Tmux
alias tmux-n="tmux new -t"
alias tmux-l="tmux list-sessions"
alias tmux-kill="tmux kill-session -t"
alias tmux-k="tmux kill-session -t"
# Tmuxifier
alias tx-ns="tmuxifier new-session"
alias tx-ls="tmuxifier load-session"
alias tx-es="tmuxifier edit-session"
alias tx-list="tmuxifier list"
alias tx-l="tmuxifier list"
alias tx-layouts="cd ~/.tmuxifier/layouts/"

# VM
alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

# Apps
alias musica="ncmpcpp"

# cd easily & multiple times

alias ....='cd ../../'
alias .4='cd ../../'

alias .....='cd ../../../'
alias .5='cd ../../../'

# cd into projects easily
alias coding-practicce="cd ~/keep-coding/programming/"
alias python-projects="cd ~/keep-coding/python/"
alias cpp-projects="cd ~/keep-coding/low-lvl/"
alias sql-projects="cd ~/keep-coding/sql/"
alias app-dev="cd ~/keep-coding/app-dev/"
alias web-dev="cd ~/keep-coding/web-dev/"
alias web-projects="cd ~/keep-coding/web-dev/projects/"
alias web-games="cd ~/keep-coding/web-dev/game-dev/"
alias ricing="cd ~/keep-coding/nix-customization/"

# Show path
alias path='echo -e ${PATH//:/\\n}'

# Show datetime
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'

# become root #
alias root='sudo -i'
alias su='sudo -i'

# Add flags to existing aliases.
alias tmux='tmux -u'
alias tree='tree -a -I .git'
alias ls='lsd --group-directories-first'
alias ll='lsd --group-directories-first -l'
# Networking
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Resume wget by default
alias wget='wget -c'

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Calculator
alias bc='bc -l'

# Generate sha1 digest
alias sha1='openssl sha1'

# create parent directories on demand
alias mkdir='mkdir -pv'

# Open config files quickly
alias zshrc='nvim ~/.zshrc'
alias nvimrc='~/.config/nvim && nvim'
alias tmuxrc='nvim ~/.config/tmux/tmux.conf'
alias tx-layoutsrc='~/.tmuxifier/layouts/ && nvim'
alias alacrittyrc='~/.config/alacritty/ && nvim .'
alias polybarrc='~/config/polybar/ && nvim .'
alias i3rc='~/.config/i3/ && nvim .'
alias bspwmrc='~/.config/bspwm/ && nvim .'
alias rofirc='~/.config/rofi/ && nvim .'
alias dunstrc='~/.config/dunst/ && nvim .'

# ╔╗╔┌─┐┌─┐┬  ┬┬┌┬┐  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐  ┌─┐┬ ┬┬┌┬┐┌─┐┬ ┬┌─┐┬─┐
# ║║║├┤ │ │└┐┌┘││││  │  │ ││││├┤ ││ ┬  └─┐││││ │ │  ├─┤├┤ ├┬┘
# ╝╚╝└─┘└─┘ └┘ ┴┴ ┴  └─┘└─┘┘└┘└  ┴└─┘  └─┘└┴┘┴ ┴ └─┘┴ ┴└─┘┴└─
# Neovim config switcher

# alias
alias vi="vim"
alias nvi="nvim"
# prebuilt
alias lazyVim="NVIM_APPNAME=LazyVim nvim"
alias nvlazy="NVIM_APPNAME=LazyVim nvim"
alias nvastro="NVIM_APPNAME=AstroNvim nvim"
alias nvchad="NVIM_APPNAME=NvChad nvim"
# custom
alias nvcode="NVIM_APPNAME=Nvcode nvim"
alias nvnoice="NVIM_APPNAME=NoiceVim nvim"

function nvims() {
  items=("LazyVim" "NvChad" "AstroNvim" "NoiceVim" "Nvcode")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config - " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
bindkey -s "^a" "nvims\n"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Startup
neofetch


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/falconcodes/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/falconcodes/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/falconcodes/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/falconcodes/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

