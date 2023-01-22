eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#if [ -z "$TMUX" ]
#then
#    tmux attach -t TMUX || tmux new -s TMUX
#fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /Users/joaorafael/.docker/init-bash.sh || true # Added by Docker Desktop
