#!/bin/sh
# Zap Plugin Manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

source $HOME/keep-coding/fast-project-package/fast-project.sh

# plugins
# plug "esc/conda-zsh-completion"
plug "zap-zsh/completions"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "MAHcodes/distro-prompt"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

eval "$(zoxide init zsh)"
# eval "`pip3 completion --zsh`"

# Zsh cool options
# setopt AUTOCD            # cd into directly without writing cd
setopt PROMPT_SUBST      # enable command substitution in prompt
setopt MENU_COMPLETE     # Automatically highlight first element of completion menu
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS  # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.

HISTFILE=~/.cache/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Add to Path
export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export GPG_TTY=$TTY
# export XDG_CURRENT_DESKTOP="Wayland"

# conda
export PATH="$HOME/miniconda/bin:$PATH"

# pnpm
export PNPM_HOME="/home/falconcodes/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Flutter
export PATH="$PATH:/opt/flutter"
export ANDROID_SDK_ROOT="/home/falconcodes/Android/Sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"

# Keybinds
bindkey '^ ' autosuggest-accept

# if command -v bat &> /dev/null; then
#   alias cat="bat -pp --theme \"Visual Studio Dark+\""
#   alias catt="bat --theme \"Visual Studio Dark+\""
# fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


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

# Aliases
# Arch
#alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
#alias arch-mirrors="sudo reflector --verbose --latest 5 --country 'India' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
#alias arch-maintenance="yay -Sc && sudo pacman -Scc"
#alias arch-purge="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
#alias arch-update="sudo pacman -Syu --nocombinedupgrade"

# Maintenance
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Networking
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Resume wget by default
alias wget='wget -c'
alias kill-port='kill -9 $(lsof -t -i:$1)'
# Generate sha1 digest
alias sha1='openssl sha1'

# Calculator
alias bc='bc -l'

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

# Become root #
alias root='sudo -i'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# Remarkable SSH
alias remarkable_ssh='ssh root@10.11.99.1'
alias restream='restream -p'
# systemd

alias mach_list_systemctl="systemctl list-unit-files --state=enabled"
alias mach_java_mode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""

# VM
alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Execute frequent commands with useful flags.
alias tree='tree -a -I .git'
alias ls='lsd --group-directories-first'
alias ll='lsd --group-directories-first -l'
# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# Create parent directories on demand
alias mkdir='mkdir -pv'
# Easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
# pbcopy & pbpaste
alias pbcopy='xclip -selection clipboard'
# alias pbpaste='xclip -o'

# ASCII shibang
alias shibang='cermic 1 ~/keep-coding/falcon-dots/cermic-sh-art/images;echo ""'

# Shortcuts
# Tmux
# The alias `tmux='tmux -u'` is setting up an alias for the `tmux` command. In this case, when you type `tmux` in the terminal, it will actually execute `tmux -u`. The `-u` flag in `tmux -u` stands for "update-environment" and it ensures that the environment variables are updated when a new session is created or an existing session is attached. This can be useful to make sure that the environment variables are consistent across different tmux sessions.
# alias tmux='tmux -u'
alias tmux-kill="tmux kill-session -t"

# cd easily & multiple times
alias ..='z ..'
alias ....='z ../../'
alias ..2='z ../../'
alias .....='z ../../../'
alias ..3='z ../../../'
# cd into projects easily
alias work="cd ~/keep-coding/work/"

# Open config files quickly
alias zshrc='nvi ~/.zshrc'
alias tmuxrc='nvi ~/.config/tmux/tmux.conf'
# Open Dotfiles quickly
alias dots='cd ~/keep-coding/falcon-dots/ && nvi .' # dotfiles are symlinked to this directory
# Open config folders quickly
alias nvimrc='cd ~/.config/nvim && nvi .'
alias alacrittyrc='cd ~/.config/alacritty/ && nvi .'
alias polybarrc='cd ~/config/polybar/ && nvi .'
alias i3rc='cd ~/.config/i3/ && nvi .'
alias bspwmrc='cd ~/.config/bspwm/ && nvi .'
alias rofirc='cd ~/.config/rofi/ && nvi .'
alias dunstrc='cd ~/.config/dunst/ && nvi .'

# Neovim config switcher
alias vi="vim"
alias nvi="nvim-alt"
# Vimacs with nvchad
alias nvchad="NVIM_APPNAME=nvchad nvim"

# Docker
alias docker-kill-all-containers='docker kill $(docker ps -q)'
alias docker-remove-all-containers='docker rm $(docker ps -a -q)'
alias docker-remove-all-images='docker rmi $(docker image ls -a -q)'

# On demand docker containers using compose templates
function foo() {
   local container=$1
   local volume=$2

   cat <<EOF > ~/keep-coding/work/new-compose-file.yaml
   version: "3"
     services:
       ${container}:
     image: nodered/node-red
     ports:
       - "3000:1880"
     volumes:
       - ./${volume}/:/data
EOF
# sed 's/node_red_container/new_docker_container/' template.yml | sed 's/node-red-data/new-volume/';
}

# docker-compose-template
function docker-compose-template() {
echo "TODO: Create templates for MERN & React + SQL projects"
}

# Postgresql
function postgres() {
    local cmd=$1
    local user=${2:-falconcodes}
    local db=${3:-postgres}
    local file=$4
    if [ "$1" = "start" ]; then
        docker-compose -f ~/keep-coding/db-docker/postgres_server/docker-compose.yml -p postgres_db up -d
    elif [ "$1" = "stop" ]; then
        docker rm -f postgres_db
    elif [ "$1" = "run" ]; then
        docker exec -it postgres_db psql -U $user $db
    elif [ "$1" = "exec" ]; then
        docker exec -it postgres_db psql -U $user -d $db -f $file
    else
        echo "Invalid command"
    fi
}

# Github cli
function gh_work() {
  # Get the current GitHub user
  current_user=$(gh auth status --hostname github.com | grep Logged | awk '{print $7}' | head -n 1)

  echo "Current User is $current_user"
  if [ "$current_user" = "Prathamesh-Chavan-Noovosoft" ]; then

    if [ "$1" = "repo" ] && [ "$2" = "create" ]; then

    # Determine the correct SSH hostname
    ssh_hostname="github.com-work"

    echo "Disclaimer: You are using your work account. Remote will be set as your work git hostname (github.com-work)."

    # Prompt for the repository name
    echo -n "Enter the repository name ($(basename $PWD)): "
    read repo_name

    # Create the repository
    gh repo create $repo_name

    # Use the current folder name if no name is provided
    if [ -z "$repo_name" ]; then
      repo_name=$(basename "$PWD")
    fi

    # Set the remote URL
    git remote set-url origin git@$ssh_hostname:$current_user/$repo_name.git
    echo "$(git remote -v)"

    else
      echo "Disclaimer: You are using gh from your work account."
      command gh "$@"
    fi

  else
    echo "You are not signed in into Prathamesh-Chavan-Noovosoft! Login with your work account to continue."
  fi
}

# run_fastfetch
function run_fastfetch() {
  # Define the path of your temp file
  TMPFILE="$HOME/.last_fetch_run"

  # Check if the temp file exists and if it was modified in the last 2 minutes
  if [[ ! -e "$TMPFILE" || "$(find "$TMPFILE" -mmin +2)" ]]; then
      # Run fetch, outside tmux
    if [[ -z "$TMUX" ]]; then
        fastfetch
    fi
      # Touch the temp file to update its last modified time
      touch "$TMPFILE"
  fi

}

# My configs
alias nvold="NVIM_APPNAME=nvim-old nvim"
alias nvim-old="NVIM_APPNAME=nvim-old nvim"
alias nvalt="NVIM_APPNAME=nvim-alt nvim"
alias nvim-alt="NVIM_APPNAME=nvim-alt nvim"
alias nvminimal="NVIM_APPNAME=nvim-minimal nvim"
alias nvim-minimal="NVIM_APPNAME=nvim-minimal nvim"

# Configs' launcher function
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

# ASCII Shibang #!
shibang
