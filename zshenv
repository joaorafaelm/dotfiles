export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS="
  --height 75% --multi --reverse
  --bind ctrl-y:preview-up,ctrl-e:preview-down
  --preview-window noborder
"
alias fd=fdfind
alias gc="gh pr list | fzf --preview 'gh pr diff --color=always {+1} | delta' | awk '{print \$1}' | xargs gh pr checkout"
