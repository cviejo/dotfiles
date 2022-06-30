# exports
# -------------------------------------------------------------
export BAT_STYLE=changes
export BAT_THEME=base16
export CLICOLOR=1
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='ag --hidden -f -g ""'
export FZF_DEFAULT_OPTS=''
export KEYTIMEOUT=1
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LSCOLORS=GxFxCxDxBxegedabagaced
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/args
export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh
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
plugins=(fzf fzf-tab git zsh-autosuggestions zsh-syntax-highlighting z)
DISABLE_AUTO_UPDATE=true ZSH_THEME=cv safeSource $HOME/.oh-my-zsh/oh-my-zsh.sh

# aliases
# -------------------------------------------------------------
alias c="clear; set-cursor insert"
alias e='exit'
alias n='nvim'
alias ranger='RD=$HOME/.config/ranger/dir; ranger --choosedir=$RD; cd `cat $RD`'
alias r='ranger'
alias t='tmux new-session -A -s main'
alias tl="~/.local/bin/tmuxp-load-fzf"
alias gc='git checkout $(git branch | fzf)'
alias gi='git add -i'
alias gm='git commit --no-verify -m '
alias gf='git fetch -p && git rebase'
alias gp='git push'
alias gr='git pull -r'
alias qr="qrencode -o - -t UTF8 "

# local scripts
# -------------------------------------------------------------
safeSource $HOME/.zshrc-vim
safeSource $HOME/.zshrc-local
safeSource $HOME/.nix-profile/etc/profile.d/nix.sh
safeSource $HOME/.config/fzf/theme.sh
