if [[ -n ${ZSH_VERSION-} ]]; then
  local GREEN="%F{green}"
  local BLUE="%F{blue}"
  local RED="%F{red}"
  local YELLOW="%F{yellow}"
  local COLOREND="%F{white}"
else
  local GREEN="\[\e[0;32m\]"
  local BLUE="\[\e[0;34m\]"
  local RED="\[\e[0;31m\]"
  local YELLOW="\[\e[0;33m\]"
  local COLOREND="\[\e[00m\]"
fi

export GIT_PS1_SHOWUNTRACKEDFILES=yes

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

  if [[ `tput cols` -lt 110 ]]; then
    branch=`echo $branch | sed s/feature/f/1`
    branch=`echo $branch | sed s/hotfix/h/1`
    branch=`echo $branch | sed s/release/\r/1`

    branch=`echo $branch | sed s/master/mstr/1`
    branch=`echo $branch | sed s/develop/dev/1`
  fi

  if [[ $branch != "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1 | grep -F "nothing to commit") ]]; then
      echo -e "${GREEN}$branch${COLOREND} "
    else
      echo -e "${RED}$branch${COLROEND} "
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

  workingdir=""
  if [[ `tput cols` -lt 100 ]]; then
    first="/`echo $dir | cut -d / -f 2`"
    letter=${first:0:2}
    if [[ $in_home == 1 ]]; then
      letter="~$letter"
    fi
    proj=`echo $dir | cut -d / -f 3`
    beginning="$letter/$proj"
    end=`echo "$dir" | rev | cut -d / -f1 | rev`

    if [[ $proj == "" ]]; then
      workingdir="$dir"
    elif [[ $proj == "~" ]]; then
      workingdir="$dir"
    elif [[ $dir =~ "$first/$proj"$ ]]; then
      workingdir="$beginning"
    elif [[ $dir =~ "$first/$proj/$end"$ ]]; then
      workingdir="$beginning/$end"
    else
      workingdir="$beginning/…/$end"
    fi
  else
    workingdir="$dir"
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

  PS1="\u $(working_directory)$(parse_git_branch)$(parse_remote_state)${COLOREND}$ "
}

zsh_prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${BLUE}›${COLOREND} "
  else
    exit_status="${RED}›${COLOREND} "
  fi

  echo -e "%n $(working_directory)$(parse_git_branch)$(parse_remote_state)${COLOREND}$ "
}

if [[ -n $ZSH_VERSION ]]; then
  precmd() { PROMPT="$(zsh_prompt)%" }
else
  PROMPT_COMMAND=bash_prompt
fi
