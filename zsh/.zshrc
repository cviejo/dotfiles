# exports
export BAT_STYLE=changes
export BAT_THEME=base16
export CLICOLOR=1
export EDITOR=nvim
export KEYTIMEOUT=1
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LSCOLORS=GxFxCxDxBxegedabagaced
export TERM=xterm-256color
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/args
export ZSH=$HOME/.oh-my-zsh
export MANPAGER='nvim +Man!'
export FZF_DEFAULT_COMMAND='ag --hidden -f -g ""'
export FZF_DEFAULT_OPTS=''
export FZF_BASE=$HOME/.local/bin
export DISABLE_FZF_KEY_BINDINGS="true"

# local data
export HISTFILE=$HOME/.local/share/zsh/.history
export NODE_REPL_HISTORY=$HOME/.local/share/node/.repl_history
export ZSHZ_DATA=$HOME/.local/share/zsh/.z
export ZSH_COMPDUMP=$HOME/.local/share/zsh/.zcompdump-$HOST-$ZSH_VERSION

if [[ ! -z $TMUX ]]; then
	export TERM=screen-256color
fi

safeSource(){
	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}

# oh-my-zsh
plugins=(fzf fzf-tab git zsh-autosuggestions zsh-syntax-highlighting z zsh-vi-mode)
DISABLE_AUTO_UPDATE=true ZSH_THEME=cv safeSource $HOME/.oh-my-zsh/oh-my-zsh.sh

# vim normal mode
zvm_bindkey vicmd 'ZZ' exit_zsh
zvm_bindkey vicmd '^r' fzf-history-widget
zvm_bindkey vicmd 'qh' fzf-history-widget
zvm_bindkey vicmd 'qr' fzf-history-widget
zvm_bindkey vicmd 'qp' fzf-file-widget
zvm_bindkey vicmd 'gh' beginning-of-line
zvm_bindkey vicmd 'gl' end-of-line

# vim insert mode
zvm_bindkey viins 'jj' zvm_exit_insert_mode

# aliases
alias c='clear'
alias e='exit'
alias n='nvim'
alias r='RD=$HOME/.config/ranger/dir; ranger --choosedir=$RD; cd `cat $RD`'
alias t='tmux new-session -A -s main'
alias tl="~/.local/bin/tmuxp-load-fzf"
alias gc='git checkout $(git branch | fzf)'
alias gi='git add -i'
alias gm='git commit --no-verify -S -m '
alias gf='git fetch -p && git rebase'
alias gp='git push'
alias gr='git pull -r'
alias qr="qrencode -o - -t UTF8 "

# local scripts
safeSource $HOME/.zshrc-local
safeSource $HOME/.nix-profile/etc/profile.d/nix.sh
safeSource $HOME/.config/fzf/theme.sh


# bun completions
[ -s "/Users/viejo/.bun/_bun" ] && source "/Users/viejo/.bun/_bun"
