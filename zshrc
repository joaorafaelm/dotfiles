export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/.golang
export PATH=$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/bin/:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export PYTHONWARNINGS="ignore"
export EDITOR=vim
export PATH="$PATH:/Users/joaorafael/.local/bin"
export PIPENV_VENV_IN_PROJECT=1
export PYTHONWARNINGS="ignore"
export PYTHONDONTWRITEBYTECODE=1
export PYTEST_ADDOPTS='--no-cov-on-fail -p no:warnings -s --pdb --pdbcls=IPython.terminal.debugger:Pdb -x --reuse-db -qqq --capture=no --log-cli-level=CRITICAL -p no:logging'
eval "$(pyenv init -)"
source ~/.zshenv


# Zsh cmd
ZSH_THEME="simple"
plugins=(
    git
    zsh-autosuggestions
    zsh-vi-mode
    git-auto-fetch
    git-prompt
)

source $ZSH/oh-my-zsh.sh

PROMPT='%{$fg[yellow]%}%~%{$fg_bold[yellow]%}$(git_super_status)%{$reset_color%} '
RPROMPT="%{$fg[yellow]%}%D{%b %d, %Y - %T}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX="" 
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[green]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[yellow]%}%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[yellow]%}%{↑%G%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}%{?%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[yellow]%}%{✔%G%}"
ZSH_THEME_GIT_PROMPT_CACHE=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode fzf
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
zvm_after_init_commands+=('source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh') 
alias l="exa -lha"
alias ls="exa"
alias vim="nvim"
alias v="nvim"


# git abstraction, install gawk
unalias g
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
    fi

    # update prompt
    update_current_git_vars
}

# make worktree
unalias gg
gg () {
    cd $(git worktree list | grep master | cut -f1 -d " ");
    git worktree add .features/$1;
    cp .env .features/$1/.env;
    cd .features/$1;
}

# clean worktree
gw () {
    cd $(git worktree list | grep master | cut -f1 -d " ");
    for i in $(ls .features);
    do cd .features/$i;
        git branch --merged master | grep $i$ && git worktree remove $i;
        cd ~-;
    done;
}

# update git prompt
update_current_git_vars
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
  export VISUAL="nvim"
fi
alias v="$VISUAL"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
DISABLE_MAGIC_FUNCTIONS=true
