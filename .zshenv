export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-file ~/.ignore'
export FZF_ALT_C_COMMAND="
    fd --min-depth 1 --max-depth 3 --type d \
    --hidden --follow --exclude .git --exclude node_modules \
    --exclude target --exclude .cache --exclude .stack-work \
    --exclude .ccls-cache --exclude .clangd \
    --exclude .vscode --exclude .idea --exclude .github \
    --exclude .gitlab --exclude .gitignore \
    --exclude .gitmodules --exclude .gitkeep --exclude .gitattributes \
    --exclude .DS_Store --exclude .localized --exclude .vs \
    --exclude .venv --exclude .pytest_cache --exclude .mypy_cache \
    --exclude Documents/Dev --exclude VirtualBox
"
export FZF_ALT_C_OPTS="--preview 'tree -C -S -d {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
  --history-size=999999999
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
# light theme
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
# --color=fg:#4b505b,bg:#fafafa,hl:#5079be 
# --color=fg+:#4b505b,bg+:#fafafa,hl+:#3a8b84 
# --color=info:#88909f,prompt:#d05858,pointer:#b05ccc 
# --color=marker:#608e32,spinner:#d05858,header:#3a8b84'

# dark theme
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
# --color=fg:#c5cdd9,bg:#262729,hl:#6cb6eb 
# --color=fg+:#c5cdd9,bg+:#262729,hl+:#5dbbc1 
# --color=info:#88909f,prompt:#ec7279,pointer:#d38aea 
# --color=marker:#a0c980,spinner:#ec7279,header:#5dbbc1'

alias cat="bat --plain"
alias gc="gh pr list --state all --limit 1000 | fzf --preview 'gh pr diff --color=always {+1} | delta' | awk '{print \$1}' | xargs gh pr checkout"
alias ga="git ls-files -m -o --exclude-standard | fzf -m --print0 --preview 'git diff {+} | delta' | xargs -0 git add && g c"
. "$HOME/.cargo/env"
alias ai="aichat"
export OPENAI_API_KEY=`/bin/cat ~/.config/openai.token`
