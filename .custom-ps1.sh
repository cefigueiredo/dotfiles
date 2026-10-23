if [[ -n ${ZSH_VERSION-} ]]; then
  local GREEN="%F{green}"
  local BLUE="%F{blue}"
  local RED="%F{red}"
  local YELLOW="%F{yellow}"
  local COLOREND="%F{white}"
elif [[ -n $BASH_VERSION ]]; then
  GREEN="\[\e[0;32m\]"
  BLUE="\[\e[0;34m\]"
  RED="\[\e[0;31m\]"
  YELLOW="\[\e[0;33m\]"
  COLOREND="\[\e[00m\]"
fi

export GIT_PS1_SHOWUNTRACKEDFILES=yes

PS1_PATH_MAX=30
PS1_BRANCH_MAX=35
PS1_BRANCH_HEAD=20
PS1_BRANCH_TAIL=10
PS1_LINE_MAX=75

# ~/dev/wrapbook/app/.claude/worktrees/foo -> ~/d/w/a/.c/w/foo
shorten_path() {
  local rest="$1" short="" part
  while [[ $rest == */* ]]; do
    part="${rest%%/*}"
    rest="${rest#*/}"
    if [[ $part == .* ]]; then
      part="${part:0:2}"
    else
      part="${part:0:1}"
    fi
    short="$short$part/"
  done
  echo "$short$rest"
}

# keep the first PS1_BRANCH_HEAD and last PS1_BRANCH_TAIL chars of long branches
shorten_branch() {
  local name="$1"
  if [[ ${#name} -gt $PS1_BRANCH_MAX ]]; then
    name="${name:0:$PS1_BRANCH_HEAD}...${name: -$PS1_BRANCH_TAIL}"
  fi
  echo "$name"
}

# drop zsh (%F{..}) and bash (\[..\]) color codes to measure the visible length
strip_colors() {
  echo "$1" | sed -E 's/%F\{[a-z]+\}//g; s/\\\[[^]]*\\\]//g'
}

# Responsive Prompt
parse_git_branch() {
  if [[ -n $BASH_VERSION ]] && [[ -f "$DOTFILES_PATH/.git-completion.bash" ]]; then
    branch=`__git_ps1 "%s"`
  elif [[ -n $ZSH_VERSION ]] && [[ -f "$DOTFILES_PATH/.git-completion.zsh" ]]; then
    branch=`__git_ps1 "%s"`
  else
    ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
    branch="${ref#refs/heads/}"
  fi

  # __git_ps1 appends state marks after a space ("branch *%"); only shorten the name
  if [[ $branch == *" "* ]]; then
    branch="$(shorten_branch "${branch%% *}") ${branch#* }"
  else
    branch="$(shorten_branch "$branch")"
  fi

  if [[ $branch != "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1 | grep -F "nothing to commit") ]]; then
      echo -e "${GREEN}$branch${COLOREND} "
    else
      echo -e "${RED}$branch${COLOREND} "
    fi
  fi
}

working_directory() {
  dir=`pwd`
  in_home=0
  if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
    dir="~${dir#$HOME}"
    in_home=1
  fi

  workingdir="$dir"
  if [[ ${#dir} -gt $PS1_PATH_MAX ]]; then
    workingdir="$(shorten_path "$dir")"
  fi

  echo -e "${YELLOW}$workingdir${COLOREND} "
}

parse_remote_state() {
  remote_state=$(git status -sb 2> /dev/null | grep -oh "\[.*\]")
  if [[ "$remote_state" != "" ]]; then
    out="${BLUE}[${COLOREND}"

    if [[ "$remote_state" == *ahead* ]] && [[ "$remote_state" == *behind* ]]; then
      behind_num=$(echo "$remote_state" | grep -oh "behind \d*" | grep -oh "\d*$")
      ahead_num=$(echo "$remote_state" | grep -oh "ahead \d*" | grep -oh "\d*$")
      out="$out${RED}$behind_num${COLOREND},${GREEN}$ahead_num${COLOREND}"
    elif [[ "$remote_state" == *ahead* ]]; then
      ahead_num=$(echo "$remote_state" | grep -oh "ahead \d*" | grep -oh "\d*$")
      out="$out${GREEN}$ahead_num${COLOREND}"
    elif [[ "$remote_state" == *behind* ]]; then
      behind_num=$(echo "$remote_state" | grep -oh "behind \d*" | grep -oh "\d*$")
      out="$out${RED}$behind_num${COLOREND}"
    fi

    out="$out${BLUE}]${COLOREND}"
    echo "$out "
  fi
}

bash_prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${BLUE}›${COLOREND} "
  else
    exit_status="${RED}›${COLOREND} "
  fi

  local body="$(working_directory)$(parse_git_branch)$(parse_remote_state)${COLOREND}"
  local plain="$(strip_colors "$body")$ "
  if [[ ${#plain} -gt $PS1_LINE_MAX ]]; then
    body="$body\n"
  fi

  PS1="$body$ "
}

zsh_prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${BLUE}›${COLOREND} "
  else
    exit_status="${RED}›${COLOREND} "
  fi

  local body="%n $(working_directory)$(parse_git_branch)$(parse_remote_state)${COLOREND}"
  local plain="$USER $(strip_colors "${body#%n }")$ "
  if [[ ${#plain} -gt $PS1_LINE_MAX ]]; then
    body="$body\n"
  fi

  echo -e "$body$ "
}

if [[ -n $ZSH_VERSION ]]; then
  precmd() {
    PROMPT="$(zsh_prompt)%"
  }
fi

if [[ -n ${BASH_VERSION} ]]; then
  PROMPT_COMMAND=bash_prompt
fi
