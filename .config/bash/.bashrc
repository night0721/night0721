. "${HOME}/.config/bash/.bashenv"

if lsmod | grep -wq "pcspkr"; then
  sudo rmmod pcspkr # Remove annoying beep sound in tty
fi

if ! pgrep -x "dwl" > /dev/null; then
    dwl # run dwl if not running
fi
source ~/.local/share/blesh/ble.sh
GIT_BRANCH=""
git_prompt() {
  local git_info
  git_info=$(git branch 2>/dev/null | sed 's/* //')
  if [[ -n $git_info ]]; then
    local ahead behind
    ahead=$(git log --oneline @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    behind=$(git log --oneline HEAD..@{u} 2>/dev/null | wc -l | tr -d ' ')
    if [[ $ahead -gt 0 && $behind -gt 0 ]]; then
      GIT_BRANCH="\[\e[38;5;183m\][$git_info ↑$ahead ↓$behind] "
    elif [[ $ahead -gt 0 ]]; then
      GIT_BRANCH="\[\e[38;5;183m\][$git_info ↑$ahead] "
    elif [[ $behind -gt 0 ]]; then
      GIT_BRANCH="\[\e[38;5;183m\][$git_info ↓$behind] "
    else
      GIT_BRANCH="\[\e[38;5;183m\][$git_info] "
    fi
  fi
}
git_prompt
PS1='\[\e[38;5;147m\][\t] \[\e[38;5;005m\][\w]${GIT_BRANCH}\[\e[38;5;069m\] » \[\e[0m\]'

# variables needed for command history
HISTFILE=~/.config/bash/.bash_history
HISTSIZE=5000

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

bind -x '"\C-f":"lfcd"'
bind -x '"\C-o":"cd $(dirname $(find . -name .git -prune -o -type f | fnf))"'

source ~/.autojump/share/autojump/autojump.bash

. "${HOME}/.config/bash/aliases"
