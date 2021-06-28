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

export PYTHONDONTWRITEBYTECODE=1

# Zsh cmd
ZSH_THEME="simple"
plugins=(git zsh-autosuggestions)
plugins+=(zsh-vi-mode)


source $ZSH/oh-my-zsh.sh
export PROMPT='%{$fg[yellow]%}%~%{$fg_bold[yellow]%}$(git_prompt_info)%{$reset_color%} '
export RPROMPT="%{$fg[black]%}%D{%b %d, %Y - %T}%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_PREFIX=" ("
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"
export PYTHONWARNINGS="ignore"

# Aliases
alias dokku='$HOME/.dokku/contrib/dokku_client.sh'
alias v='node ~/Dev/Other/crafty/main.js --watch'

# shitty macbook keyboard
alias lss='ls'
alias lsss='ls'

export EDITOR=vim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
source ~/.zshenv

# Created by `pipx` on 2021-04-24 23:08:21
export PATH="$PATH:/Users/joaorafael/.local/bin"

export PIPENV_VENV_IN_PROJECT=1
export PIPENV_VENV_IN_PROJECT=enabled
export PYTHONWARNINGS="ignore"
export PYTHONDONTWRITEBYTECODE=1
export PYTEST_ADDOPTS='--no-cov-on-fail -p no:warnings -s --pdb --pdbcls=IPython.terminal.debugger:Pdb -x --reuse-db -qqq --capture=no --log-cli-level=CRITICAL -p no:logging'

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

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

# vim mode fzf
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi
