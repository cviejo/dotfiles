
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

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# oh-my-zsh
ZSH_THEME="cv"
DISABLE_AUTO_UPDATE="true"
plugins=(git wd zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

bindkey '^ ' autosuggest-accept

# aliases
alias tmux='env TERM=xterm-256color tmux a || tmux new'
alias c='clear'
alias e='exit'
alias q='exit'
alias sd='sudo shutdown now'
alias mkdir='mkdir -p'
alias path='echo -e ${PATH//:/\\n}'
alias vimdiff='nvim -d'

if linux ; then
	alias pbcopy='xclip -selection clipboard'
	alias pbpaste='xclip -selection clipboard -o'
fi
alias gi='git add -i'
alias gs='git status'
alias gp='git push'
alias gr='git pull -r'
alias dsa='docker stop $(docker ps -a -q)'
alias ran='ranger'
alias ranger='ranger --choosedir=$HOME/.config/ranger/dir; \
              LASTDIR=`cat $HOME/.config/ranger/dir`; \
              cd "$LASTDIR"'
alias weather='curl wttr.in'

load "$HOME/.zshrc-local"
