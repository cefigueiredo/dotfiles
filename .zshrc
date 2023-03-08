export DOTFILES_PATH="$HOME/dev/dotfiles"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files'
export DISABLE_SPRING=true

fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit
autoload -Uz colors && colors

bindkey -v # Enable Vim mode

## setup PS1/Prompt to show git state
setopt prompt_subst

zstyle ':completion:*:*:git:*' script $DOTFILES_PATH/.git-completion.bash

source $DOTFILES_PATH/.git-prompt.sh
source $DOTFILES_PATH/.custom-ps1.sh
###

## options for history
setopt share_history # share history accross multiple sessions
setopt append_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_find_no_dups # avoid dups when searching history w\ <C+R>
setopt hist_reduce_blanks
setopt hist_verify # show command substitued by "!!" before execute

setopt correct
unsetopt correct_all

alias prune-orphan-branches="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d"
alias list-orphan-branches="git fetch -p && git branch -vv | awk '/: gone]/{print $1}'"
alias rspec="bundle exec rspec"

[ -s "/opt/homebrew/opt/asdf/libexec/asdf.sh" ] && . "/opt/homebrew/opt/asdf/libexec/asdf.sh"

# [[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -n "$(brew --prefix postgresql@13)" ] && export PATH="$(brew --prefix postgresql@13)/bin:$PATH"
[ -n "$(brew --prefix node@16)" ] && export PATH="$(brew --prefix node@16)/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# chruby
[[ -n "$(brew --prefix chruby)" ]] && source "$(brew --prefix chruby)/share/chruby/chruby.sh"
[[ -n "$(brew --prefix chruby)" ]] && source "$(brew --prefix chruby)/share/chruby/auto.sh"

[[ -n "$(which direnv)" ]] && eval "$(direnv hook zsh)";
