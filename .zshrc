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
export ZSH=$HOME/.oh-my-zsh
export ELECTRON_ENV=development
if [[ ! -z $TMUX ]]; then
	export TERM=screen-256color
fi


# fns
# -------------------------------------------------------------
safeSource(){
	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}


# oh-my-zsh
# -------------------------------------------------------------
plugins=(fzf git zsh-autosuggestions zsh-syntax-highlighting z)
DISABLE_AUTO_UPDATE=true ZSH_THEME=cv safeSource $HOME/.oh-my-zsh/oh-my-zsh.sh


# aliases
# -------------------------------------------------------------
alias c="clear; set-cursor insert"
alias e='exit'
alias gc='git checkout $(git branch | fzf)'
alias gi='git add -i'
alias gm='git commit --no-verify -m '
alias gf='git fetch -p && git rebase'
alias gp='git push'
alias gr='git pull -r'
alias h='$HOME'
alias n='nvim'
alias r='ranger'
alias qrurl="qrencode -o - -t UTF8 "
alias ranger='RD=$HOME/.config/ranger/dir; ranger --choosedir=$RD; cd `cat $RD`'
alias t='tmux new-session -A -s main'



# local scripts
# -------------------------------------------------------------
safeSource $HOME/.zshrc-vim
safeSource $HOME/.zshrc-local
safeSource $HOME/.config/fzf/base16-ocean.config
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/bit bit

if [ -e /Users/carlosviejo/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/carlosviejo/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
