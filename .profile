#!/bin/sh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/1000"

export PS1='\[\e[38;2;180;190;254m\][\t] \[\e[38;2;245;194;231m\][\w] \[\e[38;2;137;180;250m\]» \[\e[0m\]'
export ENV="$HOME/.rc"
export HISTFILE="$XDG_CACHE_HOME/${SHELL##*/}_history"
export HISTSIZE=100000

export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERM="foot"
export BROWSER="firefox"
export MANPAGER="nvim +Man!"
export PAGER="more"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$PATH:/usr/local/bin:$HOME/.local/bin/misc:$HOME/.local/bin/share:$HOME/.local/bin/system:/opt/rocm/bin"
export CDPATH=":$HOME/.config:$HOME/.nky/me:$HOME/.nky/Coding:$HOME/.nky/Coding/C:$HOME/.nky/Coding/HTML:$HOME/.nky/Coding/Markdown:$HOME/.nky/git:$HOME/.nky/coslinux:$HOME/.local/bin:$HOME/.nky/Coding/Projects:$HOME/.local/share/PrismLauncher/instances/1.8.9/minecraft"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GIT_CONFIG="$HOME/.config/git/config"
export APM_DIR="$HOME/.nky/me/argon"
export APM_KEY="$HOME/.nky/me/personal/argon"
export GPG_TTY=$(tty)

export CC="zig cc"
export CC="gcc"
export CFLAGS="-Os -mtune=native -march=native -pipe -s -flto"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"
export COS="/mnt/cos"

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
source ~/.nky/me/personal/.env

if lsmod | grep -wq "pcspkr"; then
    sudo rmmod pcspkr # Remove annoying beep sound in tty
fi

if [[ "$(tty)" == "/dev/tty1" ]]; then
	dbus-run-session dwl -s startw # run dwl if not
   # dwl -s startw # run dwl if not
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export HSA_OVERRIDE_GFX_VERSION=12.0.1
