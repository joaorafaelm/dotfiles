if [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "vscode" ] || [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    # "Skipping tmux command because TERM_PROGRAM is set to vscode."
else
    if [ -n "$ALACRITTY_WINDOW_ID" ] || [ -n "$ALACRITTY_SOCKET" ]; then
        if [ -z "$TMUX" ]; then
            tmux a -t 0 || tmux new-session \; new-window -n dotfiles -c ~/dev/dotfiles nvim
            exit
        else
            if [ $SHLVL -eq 2 ]; then
                if command -v reattach-to-session-namespace &> /dev/null; then
                    reattach-to-session-namespace -u $(id -u) $SHELL
                fi
            fi
        fi
    fi
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/.golang
export PATH=$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/bin/:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/Users/joaorafael/.local/bin"
export PATH="$HOME/.luarocks/bin:$PATH"
export PIPENV_VENV_IN_PROJECT=1
export PYENV_VERSION="3.11"
export PYTHONWARNINGS="ignore"
export PYTHONDONTWRITEBYTECODE=1
export PYTEST_ADDOPTS="-p no:warnings --ff --nf --pdb -x"
export PYTHONBREAKPOINT=pdb.set_trace
export DOCKER_DEFAULT_PLATFORM=linux/arm64/v8
export ENABLE_TTY="true"
export NODE_OPTIONS="--no-warnings"
export HOMEBREW_NO_ENV_HINTS=1
source ~/.zshenv

export ZSH_DOTENV_PROMPT=false

# Zsh cmd
plugins=(
    zsh-autosuggestions
    zsh-autocomplete
    gh
)

zstyle ':omz:plugins:gh' lazy yes
zstyle ':omz:plugins:zsh-autocomplete' lazy yes
zstyle ':omz:plugins:zsh-autosuggestions' lazy yes
zstyle ':omz:update' mode auto

source $ZSH/oh-my-zsh.sh
source ~/.headline.zsh-theme
source ~/.fzf.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

# vim mode fzf
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh;
alias vim="nvim"
alias v="nvim"
# alias l="exa"
# alias ls="exa -lha"
# alias ll="exa -lha --git"
alias :q='if [ "$SHLVL" -ge 3 ]; then kill -9 $PPID; else exit; fi'
alias ai="aichat"
alias clone="~/dev/xapo/clone.sh"
function f() { 
    # cd $(mktemp -d)
    folder=${2:-.}
    cd ~/dev/other && git clone $1 $folder && cd "$_" && tmux new-window "nvim ."; cd -;
}
function cd {
    if [[ $ZSH_EVAL_CONTEXT =~ :shfunc: ]]; then
        builtin cd "$@"
    else
        builtin cd "$@" && l
    fi
}
function space_to_continue {
    read -r -s -d ' '
}

#set history size
HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=$HISTSIZE
HISTORY_IGNORE="(ls|cd|pwd|exit)*"
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

export GPG_TTY=$(tty)
# git abstraction, install gawk
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
        g
    fi
}
compdef g="git"


# make worktree
gg () {
    if [ -z "$1" ]; then
        return
    fi

    if [ $# -gt 1 ]; then
        git $@
        return
    fi

    if [ ! -d "../.features" ]; then
        mkdir -p .features
    else
        cd ..
    fi

    if [ ! -d ".features/$1" ]; then
        cd $(git worktree list | grep -E "main|master" | cut -f1 -d " ")
        git worktree add -f .features/$1
    fi
    feature_dir=$(cd .features/$1 && pwd)
    tmux select-window -t $1 > /dev/null 2>&1 || tmux new-window -n $1 -c $feature_dir nvim

}

# clean worktree
gw () {
    cd $(git worktree list | grep -E "main|master" | cut -f1 -d " ");
    mkdir -p .features;
    for i in $(l .features);
    do cd .features/$i;
        if [ "$1" = "--dry-run" ]; then
            gh pr status | grep -i "${i}.*merged" && echo "git worktree remove $i";
        else
            gh pr status | grep -i "${i}.*merged" && git worktree remove $i;
        fi
        cd ~-;
    done;
}

# function to receive a command and run it forever until it executes successfully
loop () {

    while true; do
        $@
        if [ $? -eq 0 ]; then
            break
        fi
    done
}

if [ -n "$NVIM" ]; then
  export VISUAL="nvr -cc split --remote-wait-silent --servername ${NVIM}"
else
  export VISUAL="nvim"
fi
alias v="$VISUAL"

v="$VISUAL"
EDITOR="$VISUAL"
FCEDIT="$VISUAL"
GIT_EDITOR="$VISUAL"

DISABLE_MAGIC_FUNCTIONS=true
if command -v keychain 1>/dev/null 2>&1; then
    eval `keychain --quiet --eval --agents ssh id_rsa`
fi

# aichat
export AICHAT_ROLES_FILE="$HOME/.config/aichat/roles.yaml"
export AICHAT_CONFIG_DIR="$HOME/.config/aichat"
export OPENAI_API_KEY=$(cat ~/.config/openai.token 2>/dev/null || echo "")
export GEMINI_API_KEY=$(cat ~/.config/gemini.token 2>/dev/null || echo "")
export JIRA_API_TOKEN=$(cat ~/.config/jira.token 2>/dev/null || echo "")
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

GFilesWithFocus() {
    nvr --remote-send "<esc>:call GFilesWithFocus()<CR>" --servername $NVIM
}

FilesWithFocus() {
    nvr --remote-send "<esc>:Files<CR>" --servername $NVIM
}


zle -N GFilesWithFocus GFilesWithFocus
zle -N FilesWithFocus FilesWithFocus
bindkey '^S' GFilesWithFocus
bindkey '^V' fzf-cd-widget
bindkey "ç" fzf-cd-widget
bindkey '^I' menu-expand-or-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

function sudo () {
    unset -f sudo
    if [[ "$(uname)" == 'Darwin' ]]
    then
        if ! command grep 'pam_tid.so' /etc/pam.d/sudo --silent
        then
            command sudo sed -i -e '1s;^;auth       sufficient     pam_tid.so\n;' /etc/pam.d/sudo
        fi
        if ! command grep 'pam_reattach.so' /etc/pam.d/sudo --silent
        then
            command sudo sed -i -e '1s;^;auth     optional     /opt/homebrew/lib/pam/pam_reattach.so\n;' /etc/pam.d/sudo
        fi
    fi
    command sudo "$@"
}

exit () {
    if [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "tmux" ] && [ -n "$NVIM" ] && [ "$SHLVL" -ge 3 ]; then
        kill -9 $PPID
    else
        builtin exit
    fi
}

ghcs () {
	FUNCNAME="$funcstack[1]"
	TARGET="shell"
	local GH_DEBUG="$GH_DEBUG"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
	Supports executing suggested commands if applicable.

	USAGE

	  $FUNCNAME [flags] <prompt>

	FLAGS
	  -d, --debug              Enable debugging
	  -h, --help               Display help usage
	  -t, --target target      Target for suggestion; must be shell, gh, git
	                           default: "$TARGET"

	EXAMPLES

	- Guided experience
	  $ $FUNCNAME

	- Git use cases
	  $ $FUNCNAME -t git "Undo the most recent local commits"
	  $ $FUNCNAME -t git "Clean up local branches"
	  $ $FUNCNAME -t git "Setup LFS for images"

	- Working with the GitHub CLI in the terminal
	  $ $FUNCNAME -t gh "Create pull request"
	  $ $FUNCNAME -t gh "List pull requests waiting for my review"
	  $ $FUNCNAME -t gh "Summarize work I have done in issues and pull requests for promotion"

	- General use cases
	  $ $FUNCNAME "Kill processes holding onto deleted files"
	  $ $FUNCNAME "Test whether there are SSL/TLS issues with github.com"
	  $ $FUNCNAME "Convert SVG to PNG and resize"
	  $ $FUNCNAME "Convert MOV to animated PNG"
	EOF

	local OPT OPTARG OPTIND
	while getopts "dht:-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			target | t)
				TARGET="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	TMPFILE="$(mktemp -t gh-copilotXXX)"
	trap 'rm -f "$TMPFILE"' EXIT
	if GH_DEBUG="$GH_DEBUG" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
		if [ -s "$TMPFILE" ]; then
			FIXED_CMD="$(cat $TMPFILE)"
			print -s "$FIXED_CMD"
			echo
			eval "$FIXED_CMD"
		fi
	else
		return 1
	fi
}

alias "??"="ghcs"
alias explain='gh copilot explain "$(fc -ln -1)"'
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
