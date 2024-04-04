#!/bin/sh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/1000"

export PS1='\[\e[38;5;147m\][\t] \[\e[38;5;005m\][\w] \[\e[38;5;069m\]» \[\e[0m\]'
export ENV="$HOME/.rc"
export HISTFILE="$XDG_CACHE_HOME/${SHELL##*/}_history"
export HISTSIZE=100000

export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERM="foot"
export BROWSER="firefox"
export MANPAGER="nvimpager"
export PAGER="nvimpager" # 'nvim +Man!'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$PATH:/usr/local/bin:$HOME/.autojump/bin:$HOME/.autojump/functions:$HOME/.local/bin/misc:$HOME/.local/bin/share:$HOME/.local/bin/system:$HOME/.local/share/nvim/mason/bin"
export CDPATH=":$HOME/.config:$HOME/.nky/Coding:$HOME/.nky/Coding/C:$HOME/.nky/Coding/HTML:$HOME/.nky/Coding/Markdown:$HOME/.nky/git:$HOME/.local/bin"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GIT_CONFIG="$HOME/.config/git/config"
export PASSWORD_STORE_DIR="$HOME/.nky/Me/pass"
export GPG_TTY=$(tty)
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"

export CFLAGS="-O3 -mtune=native -march=native -pipe -s"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"

mkdir -pm 0700 "$XDG_RUNTIME_DIR"

# DE
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export XCURSOR_SIZE=24
export WLR_NO_HARDWARE_CURSORS=1

# bind -x '"\C-f":"lfcd"'
# bind -x '"\C-o":"cd $(dirname $(find . -name .git -prune -o -type f | fnf))"'

source ~/.rc
source ~/.nky/Me/personal/.env

if lsmod | grep -wq "pcspkr"; then
    doas rmmod pcspkr # Remove annoying beep sound in tty
fi

if [[ "$(tty)" == "/dev/tty1" ]]; then
    dbus-run-session dwl -s startw # run dwl if not
fi
