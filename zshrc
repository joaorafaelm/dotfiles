export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/.golang
export PATH=$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/bin/:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/Users/joaorafael/.local/bin"
export PATH="$HOME/.luarocks/bin:$PATH"
export EDITOR=vim
export PIPENV_VENV_IN_PROJECT=1
export PYTHONWARNINGS="ignore"
export PYTHONDONTWRITEBYTECODE=1
export PYTEST_ADDOPTS="--no-cov-on-fail -p no:warnings --ff -s --pdb --pdbcls=IPython.terminal.debugger:Pdb -x"
export PYTHONBREAKPOINT=ipdb.set_trace
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export ENABLE_TTY="true"
alias kubectl="minikube kubectl --"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
source ~/.zshenv

# Zsh cmd
plugins=(
    docker
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source ~/.headline.zsh-theme

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode fzf
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh;
alias vim="nvim"
alias v="nvim"
alias l="exa"
alias ls="exa -lha"
alias ll="exa -lha --git"
alias :q="exit"
alias ai="aichat"
function f() { cd $(mktemp -d) && git clone $1 . && tmux new-window "nvim ."; cd -; }


#set history size
HISTSIZE=999999999
#save history after logout
SAVEHIST=999999999
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY

# git abstraction, install gawk
g () {
    if [ $# -eq 0 ]
      then
        gawk -vOFS='' '
            NR==FNR {
                all[i++] = $0;
                difffiles[$1] = $0;
                next;
            }
            ! ($2 in difffiles) {
                print; next;
            }
            {
                gsub($2, difffiles[$2]);
                print;
            }
            END {
                if (NR != FNR) {
                    # Had diff output
                    exit;
                }
                # Had no diff output, just print lines from git status -sb
                for (i in all) {
                    print all[i];
                }
            }
        ' \
            <(git diff --color --stat=$(($(tput cols) - 3)) HEAD | sed '$d; s/^ //')\
            <(git -c color.status=always status -sb)
    else
        git $@
        g
    fi
}

# make worktree
gg () {
    cd $(git worktree list | grep develop | cut -f1 -d " ");
    git worktree add .features/$1;
    cd .features/$1;
}

# clean worktree
gw () {
    cd $(git worktree list | grep develop | cut -f1 -d " ");
    for i in $(l .features);
    do cd .features/$i;
        gh pr status | grep -i "${i}.*merged" && git worktree remove $i;
        cd ~-;
    done;
}

alias a="g add"
alias c="g c"
alias p="g push"

if [ -n "$NVIM" ]; then
  export VISUAL="nvr -cc split --remote-wait-silent +'set bufhidden=wipe' --servername ${NVIM}"
else
  export VISUAL="nvim"
fi
alias v="$VISUAL"

v="$VISUAL"
EDITOR="$VISUAL"
FCEDIT="$VISUAL"
GIT_EDITOR="$VISUAL"

DISABLE_MAGIC_FUNCTIONS=true
if command -v keychain 1>/dev/null 2>&1; then
    eval `keychain --quiet --eval --agents ssh id_rsa`
fi

alias fd=fdfind
#if [ -z "$TMUX" ]
#then
#    tmux attach -t TMUX || tmux new -s TMUX
#fi

source /Users/joaorafael/.docker/init-zsh.sh || true # Added by Docker Desktop
eval "$(github-copilot-cli alias -- "$0")"

# aichat
export AICHAT_ROLES_FILE="$HOME/.config/aichat/roles.yaml"
export OPENAI_API_KEY=`cat ~/.config/openai.token`
