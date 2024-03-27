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

export PATH="$PATH:/usr/local/bin:$HOME/.autojump/bin:$HOME/.autojump/functions:$HOME/.local/bin/misc:$HOME/.local/bin/share:$HOME/.local/bin/system"
export CDPATH=":$HOME/.config:$HOME/.nky/Coding:$HOME/.nky/Coding/C:$HOME/.local/bin"
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

# push to github with the lazy way
g() {
	git add .
	git commit -m "$1"
	git push
}

lfcd() {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME}/fff/.fff_d")"
}

c() {
    ccc "$@"
    cd "$(cat "${XDG_CACHE_HOME}/ccc/.ccc_d")"
}

ma() { section="$(test -z $2 && echo 0 || echo $1)" page="${2:-$1}" ; curl -s "https://man-api.ch/v1/buster/${section}/${page}" | nvimpager; }

manl() { man $(man -k . | awk -F'-' '{print $1}' | awk -F'(' '{ print $1 }' | sed 's/ //' | fnf); }

webjpeg() { convert $1 -sampling-factor 4:2:0 -strip -quality 75 -interlace JPEG -colorspace sRGB -resize $2 $3; }

replace() {
    echo "Type the pattern you want to replace"
    read pattern
    echo "Type the phrase you want to replace with"
    read replacewith

    find . -type f -exec sed -i "s/$pattern/$replacewith/g" {} \;
}

# bind -x '"\C-f":"lfcd"'
# bind -x '"\C-o":"cd $(dirname $(find . -name .git -prune -o -type f | fnf))"'

# source ~/.local/share/blesh/ble.sh
# . ~/.autojump/share/autojump/autojump.bash

if lsmod | grep -wq "pcspkr"; then
    doas rmmod pcspkr # Remove annoying beep sound in tty
fi

if [[ "$(tty)" == "/dev/tty1" ]]; then
    dbus-run-session dwl -s startw # run dwl if not
fi

. .rc
