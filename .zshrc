# exports
# -------------------------------------------------------------
export BAT_STYLE=changes
export BAT_THEME=base16
export CLICOLOR=1
export EDITOR=nvim
export KEYTIMEOUT=1
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LSCOLORS=GxFxCxDxBxegedabagaced
export TERM=xterm-256color
export ZSH=~/.oh-my-zsh
if [[ ! -z $TMUX ]]; then
	export TERM=screen-256color
fi


# oh-my-zsh
# -------------------------------------------------------------
DISABLE_AUTO_UPDATE=true
ZSH_THEME=cv
plugins=(fzf git zsh-autosuggestions zsh-syntax-highlighting z)
source $ZSH/oh-my-zsh.sh


# aliases
# -------------------------------------------------------------
alias c="clear; set-cursor insert"
alias e='exit'
alias gc='git checkout $(git branch | fzf)'
alias gi='git add -i'
alias gm='git commit -m '
alias gp='git push'
alias gr='git pull -r'
alias h='$HOME'
alias n='nvim'
alias r='ranger'
alias ranger='RD=$HOME/.config/ranger/dir; ranger --choosedir=$RD; cd `cat $RD`'
alias t='tmux new-session -A -s main'


# local scripts
# -------------------------------------------------------------
load(){
	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}

load $HOME/.zshrc-vim
load $HOME/.zshrc-local
load $HOME/.config/fzf/base16-ocean.config
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/bit bit
