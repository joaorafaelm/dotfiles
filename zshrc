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
source $ZSH/oh-my-zsh.sh
export PROMPT='%{$fg[yellow]%}%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
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

# make worktree
unalias gg
gg () {
    git worktree add ./.features/$1
    cp .env ./.features/$1/.env
    cd ./.features/$1
}
