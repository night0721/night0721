typeset -A colors
colors=(
  [time]="147"
  [directory]="005"
  [branch]="183"
  [prompt]="069"
)

# Function to display Git status
git_prompt() {
  local git_info
  git_info=$(git branch 2>/dev/null | sed 's/* //')
  if [[ -n $git_info ]]; then
    local ahead behind
    ahead=$(git log --oneline @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    behind=$(git log --oneline HEAD..@{u} 2>/dev/null | wc -l | tr -d ' ')
    if [[ $ahead -gt 0 && $behind -gt 0 ]]; then
      echo -n "%F{${colors[branch]}}[$git_info ↑$ahead ↓$behind]%{$reset_color%} "
    elif [[ $ahead -gt 0 ]]; then
      echo -n "%F{${colors[branch]}}[$git_info ↑$ahead]%{$reset_color%} "
    elif [[ $behind -gt 0 ]]; then
      echo -n "%F{${colors[branch]}}[$git_info ↓$behind]%{$reset_color%} "
    else
      echo -n "%F{${colors[branch]}}[$git_info]%{$reset_color%} "
    fi
  fi
}
current_time() {
  echo -n "%F{${colors[time]}}[$(date "+%H:%M:%S")]%{$reset_color%} "
}

# Set prompt
PROMPT='$(current_time)%F{${colors[directory]}}[%~%{$reset_color%}] $(git_prompt)%F{${colors[prompt]}}»%{$reset_color%} '

