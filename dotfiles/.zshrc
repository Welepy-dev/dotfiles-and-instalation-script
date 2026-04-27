export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto      # update automatically without asking

# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

autoload -Uz colors && colors
setopt PROMPT_SUBST

LAST_EXIT=0

_capture_exit_status() { LAST_EXIT=$? }
precmd_functions=(_capture_exit_status)

git_prompt_info() {
  local branch state color

  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return

  if [[ -n $(git status --porcelain 2>/dev/null) ]] || \
     [[ -n $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null | grep -v '^0[[:space:]]0$') ]]; then
    color="%F{red}"
    state="✗"
  else
    color="%F{green}"
    state="✓"
  fi

  echo "${color}[${branch} ${state}]%f"
}

exit_status() {
  if [[ $LAST_EXIT -eq 0 ]]; then
    echo "%F{green}[✔ 0]%f"
  else
    echo "%F{red}[✖ $LAST_EXIT]%f"
  fi
}
PS1=$'%F{cyan}┌[%n#%m]%f - %F{yellow}(%~)%f - $(git_prompt_info)$(exit_status)\n%F{cyan}└>%f '
