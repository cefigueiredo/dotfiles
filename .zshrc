export DOTFILES_PATH="$HOME/dev/dotfiles"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files'

fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit
autoload -Uz colors && colors

setopt prompt_subst

zstyle ':completion:*:*:git:*' script $DOTFILES_PATH/.git-completion.bash

source $DOTFILES_PATH/.git-prompt.sh
source $DOTFILES_PATH/.custom-ps1.sh

[ -s "/opt/homebrew/opt/asdf/libexec/asdf.sh" ] && . "/opt/homebrew/opt/asdf/libexec/asdf.sh"

# [[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# chruby
[[ -n "$(brew --prefix chruby)" ]] && source "$(brew --prefix chruby)/share/chruby/chruby.sh"
[[ -n "$(brew --prefix chruby)" ]] && source "$(brew --prefix chruby)/share/chruby/auto.sh"

[[ -n "$(which direnv)" ]] && eval "$(direnv hook zsh)";
