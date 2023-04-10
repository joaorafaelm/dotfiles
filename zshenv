export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS="
  --height 75% --multi --reverse
  --bind ctrl-y:preview-up,ctrl-e:preview-down
  --preview-window noborder
  --no-separator --margin 0 --padding 0
"
alias fd=fdfind
alias cat="bat --plain"
alias gc="gh pr list --state all --limit 1000 | fzf --preview 'gh pr diff --color=always {+1} | delta' | awk '{print \$1}' | xargs gh pr checkout"
. "$HOME/.cargo/env"
alias ai="aichat"
export OPENAI_API_KEY=`/bin/cat ~/.config/openai.token`
