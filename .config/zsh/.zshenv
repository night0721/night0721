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
export BAT_THEME="Catppuccin-mocha" # https://github.com/catppuccin/bat
export PASSWORD_STORE_DIR="$HOME/.nky/Me/pass"
export GPG_TTY=$(tty)
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"

export LC_ALL=en_US.UTF-8

# DE
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export XCURSOR_SIZE=24
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER=gles2
