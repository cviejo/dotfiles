
source ./.zshrc-local


# vars
export LANG=en_US.UTF-8
export LC_COLLATE="C"
export EDITOR="nvim"
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh


# oh-my-zsh
ZSH_THEME="cv" # "robbyrussell", "bira", "random"
plugins=(git)
source $ZSH/oh-my-zsh.sh


# aliases
alias tmux="env TERM=xterm-256color tmux"
alias c='clear'
alias e='exit'
alias q='exit'
alias sd='sudo shutdown now'
alias path='echo -e ${PATH//:/\\n}'
alias vimdiff='nvim -d'
alias ran='ranger'
alias ranger='ranger --choosedir=$HOME/.config/ranger/dir; \
	LASTDIR=`cat $HOME/.config/ranger/dir`; \
	cd "$LASTDIR"'

