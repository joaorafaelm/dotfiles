export BAT_THEME="gruvbox-dark"
export PATH=export PATH=/Users/Shared/DBngin/postgresql/12.2/bin:$PATH:$PATH
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS='
  --height 75% --multi --reverse
  --bind ctrl-y:preview-up,ctrl-e:preview-down
'

# file search
fzf_grep_edit(){
    local match=$(
      rg --sortr=modified --smart-case --color=never --line-number "$1" |
        fzf -i --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1} --highlight-line {2}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        tmux split-window -t $TMUX_PANE $EDITOR "$file" +$(echo "$match" | cut -d':' -f2) </dev/tty
    fi
}

zle -N fzf-grep-edit fzf_grep_edit
bindkey "©" fzf-cd-widget
bindkey "†" fzf-grep-edit
alias fd=fdfind
