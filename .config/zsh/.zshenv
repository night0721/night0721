# defualt apps
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERM="foot"
export BROWSER="firefox"

# Adds ~/.local/bin and subfolders to $PATH
export PATH="$PATH:~/.local/npm/bin:${$(find ~/.local/bin -maxdepth 1 -type d -printf %p:)%%:}"

# cleaning up home folder
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

#export LESSHISTFILE="-"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export ZDOTDIR="$HOME/.config/zsh"
export GIT_CONFIG="$HOME/.config/git/config"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8" # https://github.com/catppuccin/fzf
export BAT_THEME="Catppuccin-mocha" # https://github.com/catppuccin/bat
export BEMENU_OPTS='--fb "#1e1e2e" --ff "#cdd6f4" --nb "#1e1e2e" --nf "#cdd6f4" --tb "#1e1e2e" --hb "#1e1e2e" --tf "#f38ba8" --hf "#f9e2af" --nf "#cdd6f4" --af "#cdd6f4" --ab "#1e1e2e" -H 24 --cw 1 -i --fn "jetbrains mono nerd font" -p "Menu"'
export PASSWORD_STORE_DIR="$HOME/.nky/Me/pass"

export LC_ALL=en_US.UTF-8

# DE
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export XCURSOR_SIZE=24
export WLR_NO_HARDWARE_CURSORS=1
