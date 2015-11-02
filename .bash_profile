source .git-completion.bash
source .git-prompt.sh
source .custom-ps1.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

eval "$(direnv hook $0)";
eval "$(docker-machine env default)"
