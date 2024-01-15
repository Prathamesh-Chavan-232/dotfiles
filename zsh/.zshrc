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

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

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

# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun completions
# [ -s "/Users/chris/.bun/_bun" ] && source "/Users/chris/.bun/_bun"
neofetch
