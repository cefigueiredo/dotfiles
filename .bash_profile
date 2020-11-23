source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
source $HOME/.custom-ps1.sh

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export EDITOR=nvim

export FZF_DEFAULT_COMMAND='rg --files'

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[[ -s "/usr/local/opt/nvm/nvm.sh" ]] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ]] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(direnv hook $0)";
