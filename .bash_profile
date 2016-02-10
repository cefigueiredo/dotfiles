source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
source $HOME/.custom-ps1.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

eval "$(direnv hook $0)";
