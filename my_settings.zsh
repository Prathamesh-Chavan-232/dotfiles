# Export to Path
export PATH="$PATH:/home/falconcodes/flutter/bin"
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

# Startup
neofetch

