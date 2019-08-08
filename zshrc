export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/.golang
export PATH=$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/bin/:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PYTHONDONTWRITEBYTECODE=1

ZSH_THEME="simple"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PROMPT='%{$fg[yellow]%}%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} $ '
export ZSH_THEME_GIT_PROMPT_PREFIX=" ("
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"
alias dokku='$HOME/.dokku/contrib/dokku_client.sh'
alias vape='node ~/Dev/Other/crafty/main.js'
