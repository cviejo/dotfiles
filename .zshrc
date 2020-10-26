
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


# vim
# -------------------------------------------------------------
set-cursor(){
	cursor=$1
	if [[ $cursor == insert ]]; then
		echo -ne '\e[5 q'
	else
		echo -ne '\e[1 q'
	fi
}
set-cursor insert

bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^r' fzf-history-widget # / history-incremental-search-backward
bindkey '^f' autosuggest-accept
bindkey '^?' backward-delete-char
bindkey '^u' kill-whole-line
bindkey '^p' up-line-or-search
bindkey -a 'ZZ' exit_zsh
bindkey -a ';q' exit_zsh

zle-keymap-select() {
	if [ $KEYMAP = vicmd ]; then
		set-cursor normal
	else
		set-cursor insert
	fi
	if typeset -f prompt_pure_update_vim_prompt_widget > /dev/null; then
		prompt_pure_update_vim_prompt_widget
	fi
}

zle-line-init() {
	if [[ $cursor == normal ]]; then
		zle -K vicmd;
	fi
}

exit_zsh() {
	exit
}

zle -N exit_zsh
zle -N zle-keymap-select
zle -N zle-line-init


# aliases
# -------------------------------------------------------------
alias c="clear; set-cursor insert"
alias e='exit'
alias n='nvim'
alias t='tmux new-session -A -s main'
alias gc='git checkout $(git branch | fzf)'
alias gi='git add -i'
alias gp='git push'
alias gr='git pull -r'
alias r='ranger'
alias ranger='RD=$HOME/.config/ranger/dir; ranger --choosedir=$RD; cd `cat $RD`'


# local configs
# -------------------------------------------------------------
load(){
	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}

load $HOME/.zshrc-local
load $HOME/.config/fzf/base16-ocean.config
