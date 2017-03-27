
if [[ -f ~/.zshrc-local && -r ~/.zshrc-local ]]; then
	source ~/.zshrc-local
fi

# vars
export LANG=en_US.UTF-8
export LC_COLLATE="C"
export EDITOR="nvim"
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
export PATH="$PATH:`yarn global bin`"
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# oh-my-zsh
ZSH_THEME="cv" # "robbyrussell", "bira", "random"
plugins=(git wd)
source $ZSH/oh-my-zsh.sh


# aliases
alias tmux="env TERM=xterm-256color tmux a || tmux new"
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
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
