
# functions
function linux(){
	if [ "$(uname 2> /dev/null)" = "Linux" ]; then
		return 0
	else
		return 1
	fi
}

function chpwd(){
	emulate -L zsh
	if linux ; then
		ls --color -1a --group-directories-first
	else
		ls
	fi
}

function mkcd(){
	mkdir $1
	cd $1
}

function gitbranch(){
	git checkout -b $1
	git push -u origin HEAD
}

function load(){
	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}

function tmuxActive(){
	if [[ ! -z $TMUX ]]; then
		return 0
	else
		return 1
	fi
}

function newtask(){
	task add new task | awk 'gsub(/.*\ |\./, "")' | xargs task edit
}

function f() {
	bash $HOME/.scripts/fff "$@"
	cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}



# vars
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG=en_US.UTF-8
export LC_COLLATE="C"
export EDITOR="nvim"
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
 
if hash yarn 2>/dev/null; then
export PATH="$PATH:`yarn global bin`"
fi


# oh-my-zsh
ZSH_THEME="cv"
DISABLE_AUTO_UPDATE="true"
plugins=(
	git
	wd
	zsh-autosuggestions
	zsh-syntax-highlighting
	z
)
source $ZSH/oh-my-zsh.sh

bindkey '^f' autosuggest-accept

# aliases
alias t='tmux new-session -A -s main'
alias c='clear'
alias e='exit'
alias q='exit'
alias sd='sudo shutdown now'
alias st='syncthing -no-browser'
alias mkdir='mkdir -p'
alias path='echo -e ${PATH//:/\\n}'
alias vimdiff='nvim -d'

if linux ; then
	alias pbcopy='xclip -selection clipboard'
	alias pbpaste='xclip -selection clipboard -o'
else 
	alias google-chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
fi
alias gi='git add -i'
alias gs='git status'
alias gp='git push'
alias gr='git pull -r'
alias dsa='docker stop $(docker ps -a -q)'
alias ran='ranger'
alias r='ranger'
alias ranger='ranger --choosedir=$HOME/.config/ranger/dir; \
              LASTDIR=`cat $HOME/.config/ranger/dir`; \
              cd "$LASTDIR"'
alias weather='curl wttr.in'
alias translate='gawk -f <(curl -Ls git.io/translate) -- -shell'
alias d='docker'

load "$HOME/.cargo/env"
load "$HOME/.zshrc-local"
