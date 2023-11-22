# aliases
source "${XDG_CONFIG_HOME}/zsh/aliases"

#options
unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

autoload -U compinit 
compinit

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# theme/plugins
source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $XDG_CONFIG_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $XDG_CONFIG_HOME/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source $XDG_CONFIG_HOME/zsh/n.zsh-theme

# history substring search options
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zstyle ':completion:*' menu select

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# autojump
[[ -s /home/night/.autojump/etc/profile.d/autojump.sh ]] && source /home/night/.autojump/etc/profile.d/autojump.sh

# push to github with the lazy way
g() {
	git add .
	git commit -m "$1"
	git push
}
