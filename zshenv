export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-file ~/.ignore'
export FZF_ALT_C_OPTS="--preview 'tree -C -S {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
"
export FZF_CTRL_T_OPTS="
  --preview-window noborder --margin=0 --padding=0 --no-separator
  --preview 'bat -n --color=always --line-range :500 {}'
  --inline-info --border=none --no-scrollbar
"
export FZF_COMPLETION_OPTS="
  --preview 'bat -n --color=always --line-range :500 {}'
  --preview-window noborder
  --no-separator --margin=0 --padding=0
  --inline-info --border=none --no-scrollbar
"
export FZF_DEFAULT_OPTS="
  --height 75% --multi --reverse
  --bind ctrl-y:preview-up,ctrl-e:preview-down
  --preview-window noborder
  --no-separator --margin=0 --padding=0
  --inline-info --border=none --no-scrollbar
"
alias fd=fdfind
alias cat="bat --plain"
alias gc="gh pr list --state all --limit 1000 | fzf --preview 'gh pr diff --color=always {+1} | delta' | awk '{print \$1}' | xargs gh pr checkout"
. "$HOME/.cargo/env"
alias ai="aichat"
export OPENAI_API_KEY=`/bin/cat ~/.config/openai.token`
