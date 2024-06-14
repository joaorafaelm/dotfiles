if [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "vscode" ] || [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    # "Skipping tmux command because TERM_PROGRAM is set to vscode."
else
    if [ -z "$TMUX" ]; then
        tmux a -t || tmux new-session \; new-window -n dotfiles -c ~/dev/dotfiles nvim
        exit
    else
        if [ $SHLVL -eq 2 ]; then
            reattach-to-session-namespace -u $(id -u) $SHELL
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
export PYTEST_ADDOPTS="--no-cov-on-fail -p no:warnings --ff --nf --pdb -x"
export PYTHONBREAKPOINT=ipdb.set_trace
export DOCKER_DEFAULT_PLATFORM=linux/arm64/v8
export ENABLE_TTY="true"
export NODE_OPTIONS="--no-warnings"
export HOMEBREW_NO_ENV_HINTS=1
export AIDER_AUTO_COMMITS="false"
export AIDER_YES="true"
export AIDER_TEST_CMD="make test"
export AIDER_DARK_MODE="true"
AiDER_DARK_MODE="true"
alias kubectl="minikube kubectl --"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
source ~/.zshenv

export ZSH_DOTENV_PROMPT=false

# Zsh cmd
plugins=(
    docker
    zsh-autosuggestions
    dotenv
    docker-compose
    gh
    git-auto-fetch
)

source $ZSH/oh-my-zsh.sh
source ~/.headline.zsh-theme

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,bold"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode fzf
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh;
alias vim="nvim"
alias v="nvim"
alias l="exa"
alias ls="exa -lha"
alias ll="exa -lha --git"
alias :q='if [ "$SHLVL" -ge 3 ]; then kill -9 $PPID; else exit; fi'
alias ai="aichat"
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
        return;
    fi
    cd $(git worktree list | grep -E "main|master" | cut -f1 -d " ");
    if [ ! -d ".features" ]; then
        mkdir .features;
    fi
    git worktree add .features/$1;
    cd .features/$1;
}

# clean worktree
gw () {
    cd $(git worktree list | grep -E "main|master" | cut -f1 -d " ");
    if [ ! -d ".features" ]; then
        mkdir .features;
    fi
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

source /Users/joaorafael/.docker/init-zsh.sh || true
eval "$(github-copilot-cli alias -- "$0")"

# aichat
export AICHAT_ROLES_FILE="$HOME/.config/aichat/roles.yaml"
export AICHAT_CONFIG_DIR="$HOME/.config/aichat"
export OPENAI_API_KEY=`cat ~/.config/openai.token`
export JIRA_API_TOKEN=`cat ~/.config/jira.token`
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
# disabled as it is falsely triggered by any comma and space
# bindkey ", " FilesWithFocus

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
