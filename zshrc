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

# Pretty gitdiff
gdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}
export BAT_THEME="gruvbox"
export PATH=export PATH=/Users/Shared/DBngin/postgresql/12.2/bin:$PATH:$PATH
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_DEFAULT_OPTS='
  --height 75% --multi --reverse
  --bind ctrl-f:page-down,ctrl-b:page-up
'
# file search
fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --smart-case --color=never --line-number "$1" |
        fzf -i --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}

alias f='fzf_grep_edit'
