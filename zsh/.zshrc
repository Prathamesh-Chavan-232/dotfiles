#!/bin/sh
# Zap Plugin Manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source $HOME/keep-coding/personal/fast-project-package/fast-project.sh

export PATH="$PATH:/opt/homebrew/bin"

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
export PATH=$PATH:$HOME/.cargo/bin

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# smart tmux sessions
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# Bob
export PATH=$PATH:$HOME/.local/share/bob/nvim-bin

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/falconcodes/google-cloud-sdk/path.zsh.inc' ]; then . '/home/falconcodes/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/falconcodes/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/falconcodes/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/prathameshchavan/.bun/_bun" ] && source "/Users/prathameshchavan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# set up defaults
export EDITOR="nvim"
export TERMINAL="alacritty"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export GPG_TTY=$TTY


# plugins
# plug "esc/conda-zsh-completion"
# plug "MAHcodes/distro-prompt"
plug "zap-zsh/completions"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# eval "`pip3 completion --zsh`"

# load current theme colors
autoload -U colors && colors

# custom prompts

# username@hostname directory info
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#directory info
# PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# minimal directory info
# PS1='%{$fg_bold[cyan]%}%c%{$fg[green]%}'
# PS1+="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}) > %{$reset_color%}"

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

# Keybinds
# vi mode
bindkey -v
# bindkey -M viins jk vi-cmd-mode

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^ ' autosuggest-accept

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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
    ssh_hostname="github.noovosoft"

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

# Create new tmux session in current directory
function tn() {
  tmux new -s "$(basename "$PWD")"
}

# Aliases

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

# Shortcuts
# Tmux
# The alias `tmux='tmux -u'` is setting up an alias for the `tmux` command. In this case, when you type `tmux` in the terminal, it will actually execute `tmux -u`. The `-u` flag in `tmux -u` stands for "update-environment" and it ensures that the environment variables are updated when a new session is created or an existing session is attached. This can be useful to make sure that the environment variables are consistent across different tmux sessions.
alias tmux='tmux -u'
alias tmux-kill="tmux kill-session -t"
alias ta='tmux a'

# cd easily & multiple times
alias ..='z ..'
alias ....='z ../../'
alias ..2='z ../../'
alias .....='z ../../../'
alias ..3='z ../../../'
# cd into projects easily
alias work="cd ~/keep-coding/work/"

# Docker
alias docker-kill-all-containers='docker kill $(docker ps -q)'
alias docker-remove-all-containers='docker rm $(docker ps -a -q)'
alias docker-remove-all-images='docker rmi $(docker image ls -a -q)'

# Open Dotfiles quickly
alias dots='cd ~/projects/terminal-dots/ && nvim .' # dotfiles are symlinked to this directory

# Open config files quickly
alias zshrc='nvim ~/.zshrc'
alias tmuxrc='nvim ~/.config/tmux/tmux.conf'

# My configs
# move this to nvim and remove this
alias nvim-alt="NVIM_APPNAME=nvim-alt nvim"
alias nvalt="NVIM_APPNAME=nvim-alt nvim"

alias nvim-lazy="NVIM_APPNAME=nvim-lazy nvim"
alias nvlazy="NVIM_APPNAME=nvim-lazy nvim"
alias lazyVim="NVIM_APPNAME=nvim-lazy nvim"


# Configs' launcher function
function nvims() {
  items=("default" "nvim-alt" "nvim-lazy")
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
# shibang
