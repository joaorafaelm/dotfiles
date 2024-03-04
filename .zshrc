if [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "vscode" ] || [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    # "Skipping tmux command because TERM_PROGRAM is set to vscode."
else
    if [ -z "$TMUX" ]; then
        tmux a -t || tmux new-session \; new-window -n dotfiles -c ~/dev/dotfiles nvim
    fi
fi

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
export PIPENV_VENV_IN_PROJECT=1
export PYTHONWARNINGS="ignore"
export PYTHONDONTWRITEBYTECODE=1
export PYTEST_ADDOPTS="--no-cov-on-fail -p no:warnings --ff --nf --pdb -x"
export PYTHONBREAKPOINT=ipdb.set_trace
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export ENABLE_TTY="true"
export NODE_OPTIONS="--no-warnings"
alias kubectl="minikube kubectl --"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
source ~/.zshenv

export ZSH_DOTENV_PROMPT=false

# Zsh cmd
plugins=(
    docker
    zsh-autosuggestions
    dotenv
    docker-compose
    gh
    git-auto-fetch
)

source $ZSH/oh-my-zsh.sh
source ~/.headline.zsh-theme

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey "ç" fzf-cd-widget

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
function f() { 
    # cd $(mktemp -d)
    folder=${2:-.}
    cd ~/dev/other && git clone $1 $folder && cd "$_" && tmux new-window "nvim ."; cd -;
}
function cd {
    if [[ $ZSH_EVAL_CONTEXT =~ :shfunc: ]]; then
        builtin cd "$@"
    else
        builtin cd "$@" && l
    fi
}
function space_to_continue {
    read -r -s -d ' '
}

#set history size
HISTFILE=~/.zsh_history
HISTSIZE=999999999
#save history after logout
SAVEHIST=999999999
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY

export GPG_TTY=$(tty)
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
compdef g="git"


# make worktree
# TODO: use .feature from $HOME, prepend the new branch with the project name + $1
gg () {
    cd $(git worktree list | grep -E "main|master" | cut -f1 -d " ");
    if [ ! -d ".features" ]; then
        mkdir .features;
    fi
    git worktree add .features/$1;
    cd .features/$1;
}

# clean worktree
gw () {
    cd $(git worktree list | grep -E "main|master" | cut -f1 -d " ");
    if [ ! -d ".features" ]; then
        mkdir .features;
    fi
    for i in $(l .features);
    do cd .features/$i;
        if [ "$1" = "--dry-run" ]; then
            gh pr status | grep -i "${i}.*merged" && echo "git worktree remove $i";
        else
            gh pr status | grep -i "${i}.*merged" && git worktree remove $i;
        fi
        cd ~-;
    done;
}

# function to receive a command and run it forever until it executes successfully
loop () {
    while true; do
        $@
        if [ $? -eq 0 ]; then
            break
        fi
    done
}

if [ -n "$NVIM" ]; then
  export VISUAL="nvr -cc split --remote-wait-silent --servername ${NVIM}"
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

source /Users/joaorafael/.docker/init-zsh.sh || true
eval "$(github-copilot-cli alias -- "$0")"

# aichat
export AICHAT_ROLES_FILE="$HOME/.config/aichat/roles.yaml"
export OPENAI_API_KEY=`cat ~/.config/openai.token`
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

l
