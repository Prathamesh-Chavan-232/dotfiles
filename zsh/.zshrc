#!/bin/sh

# Zap Plugin Manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# plugins
plug "esc/conda-zsh-completion"
plug "zap-zsh/completions"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "MAHcodes/distro-prompt"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# Zsh cool options
setopt AUTOCD            # cd into directly without writing cd
setopt PROMPT_SUBST      # enable command substitution in prompt
setopt MENU_COMPLETE     # Automatically highlight first element of completion menu
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS  # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.

HISTFILE=~/.cache/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Exports
export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# export XDG_CURRENT_DESKTOP="Wayland"

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

# keybinds
bindkey '^ ' autosuggest-accept

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Aliases
# Maintenance
alias mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias maintenimiento="yay -Sc && sudo pacman -Scc"
alias purga="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
alias update="sudo pacman -Syu --nocombinedupgrade"
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

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

# Useful Terminal Commands
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
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
# Remarkable
alias remarkable_ssh='ssh root@10.11.99.1'
alias restream='restream -p'
# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"
alias mach_java_mode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""

# Execute frequent commands with useful flags.
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
# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# cd easily & multiple times
alias ....='cd ../../'
alias .4='cd ../../'
alias .....='cd ../../../'
alias .5='cd ../../../'
# cd into projects easily
alias coding-practice="cd ~/keep-coding/coding-practice/"
alias python-projects="cd ~/keep-coding/python/"
alias cpp-projects="cd ~/keep-coding/low-lvl/"
alias sql-projects="cd ~/keep-coding/sql/"
alias app-dev="cd ~/keep-coding/app-dev/"
alias web-dev="cd ~/keep-coding/web-dev/"
alias web-projects="cd ~/keep-coding/web-dev/projects/"
alias web-games="cd ~/keep-coding/web-dev/game-dev/"
alias ricing="cd ~/keep-coding/nix-customization/"

# Open config files quickly
alias zshrc='nvim ~/.zshrc'
alias tmuxrc='nvim ~/.config/tmux/tmux.conf'
# Open config folders quickly
alias dots='cd ~/keep-coding/falcon-dots/ && nvim .' # dotfiles are symlinked to this directory
# Still keep these just in case
alias nvimrc='cd ~/.config/nvim && nvim .'
alias tx-layoutsrc='cd ~/.tmuxifier/layouts/ && nvim'
alias alacrittyrc='cd ~/.config/alacritty/ && nvim .'
alias polybarrc='cd ~/config/polybar/ && nvim .'
alias i3rc='cd ~/.config/i3/ && nvim .'
alias bspwmrc='cd ~/.config/bspwm/ && nvim .'
alias rofirc='cd ~/.config/rofi/ && nvim .'
alias dunstrc='cd ~/.config/dunst/ && nvim .'

# Neovim config switcher
# aliases
alias vi="vim"
alias nvi="nvim"
# vimacs with nvchad
alias nvchad="NVIM_APPNAME=nvchad nvim"
# Other people's config
alias nvim-old="NVIM_APPNAME=nvim-old nvim"
# my configs
alias nvold="NVIM_APPNAME=nvim-old nvim"
alias nvim-old="NVIM_APPNAME=nvim-old nvim"
alias nvalt="NVIM_APPNAME=nvim-alt nvim"
alias nvim-alt="NVIM_APPNAME=nvim-alt nvim"
alias nvminimal="NVIM_APPNAME=nvim-minimal nvim"
alias nvim-minimal="NVIM_APPNAME=nvim-minimal nvim"

# My configs' launcher
function nvims() {
  items=("default" "nvim-alt" "nvim-minimal" "nvim-old" "nvchad")
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

# Might be Useful some day - Do specfic things depending on the OS
case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac

neofetch
