export DOTFILES_PATH="$HOME/dev/dotfiles"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export EDITOR=nvim

export FZF_DEFAULT_COMMAND='rg --files'

[[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[[ -n "$(which direnv)" ]] && eval "$(direnv hook zsh)";
