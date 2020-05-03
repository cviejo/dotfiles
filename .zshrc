
# exports
# -------------------------------------------------------------
export CLICOLOR=1
export TERM="xterm-256color"
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG=en_US.UTF-8
export LC_COLLATE="C"
export EDITOR="nvim"
export BAT_THEME=base16
export BAT_STYLE=changes
export KEYTIMEOUT=1
export ZSH=~/.oh-my-zsh
export PATH=$HOME/.local/bin:$PATH
if hash yarn 2>/dev/null; then
	export PATH="$PATH:`yarn global bin`"
fi
if [[ ! -z $TMUX ]]; then
	export TERM="screen-256color"
fi


# aliases
# -------------------------------------------------------------
alias c="clear; echo -ne '\e[5 q'"
alias e='exit'
alias n='nvim'
alias q='exit'
alias r='ranger'
alias t='tmux new-session -A -s main'
alias gi='git add -i'
alias gp='git push'
alias gr='git pull -r'
alias mkdir='mkdir -p'
alias ranger='RD=$HOME/.config/ranger/dir; ranger --choosedir=$RD; cd `cat $RD`'
alias st='syncthing -no-browser'


# oh-my-zsh
# -------------------------------------------------------------
ZSH_THEME="cv"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z)
source $ZSH/oh-my-zsh.sh


# vim
# -------------------------------------------------------------
bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^r' history-incremental-search-backward
bindkey '^f' autosuggest-accept
bindkey '^?' backward-delete-char
bindkey '^u' kill-whole-line
bindkey '^p' up-line-or-search
bindkey -a 'ZZ' exit_zsh
bindkey -a ';q' exit_zsh

viMode=insert
echo -ne '\e[5 q'

zle-keymap-select () {
	if [ $KEYMAP = vicmd ]; then
		viMode=normal
		echo -ne '\e[1 q'
	else
		viMode=insert
		echo -ne '\e[5 q'
	fi
	if typeset -f prompt_pure_update_vim_prompt_widget > /dev/null; then
		prompt_pure_update_vim_prompt_widget
	fi
}
zle-line-init() {
	if [ $viMode = normal ]; then
		zle -K vicmd;
	fi
}
exit_zsh() { 
	exit
}

zle -N exit_zsh
zle -N zle-keymap-select
zle -N zle-line-init


# local configs
# -------------------------------------------------------------
load(){
	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}

load "$HOME/.zshrc-local"
load "$HOME/.config/fzf/base16-ocean.config"
