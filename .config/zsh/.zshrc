#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# aliases
source "${XDG_CONFIG_HOME}/zsh/aliases"

#export ZDOTDIR=$XDG_CONFIG_HOME/zsh

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

autoload -U compinit 
compinit

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# theme/plugins
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/zsh-auto-notify/auto-notify.plugin.zsh

zstyle ':completion:*' menu select

# history substring search options
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# auto notify options
AUTO_NOTIFY_IGNORE+=("lf" "hugo serve" "wofi" "cat" "bat")

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# autojump
[[ -s /home/night/.autojump/etc/profile.d/autojump.sh ]] && source /home/night/.autojump/etc/profile.d/autojump.sh

# push to github with the lazy way
g() {
	git add .
	git commit -m "$1"
	git push
}

source $XDG_CONFIG_HOME/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh


#neofetch
icat --place 10x10@0x0 /run/media/N/.nky/Photo/Profile\ Pic/me.png
echo "\n\n\n\n"
#echo "N 0.0.1"
#echo "Copyright (c) N Corporation. No rights reserved."
#echo ""
#echo "https://night.is-a.dev"

