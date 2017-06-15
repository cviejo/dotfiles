
if [[ ! -z $TMUX ]]; then
	# printf '\n';
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
alias path='echo -e ${PATH//:/\\n}'
alias vimdiff='nvim -d'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias gi='git add -i'
alias ran='ranger'
alias ranger='ranger --choosedir=$HOME/.config/ranger/dir; \
              LASTDIR=`cat $HOME/.config/ranger/dir`; \
              cd "$LASTDIR"'

# functions
function chpwd(){
   emulate -L zsh
   if linux ; then
      ls --color -a --group-directories-first
   else
      ls
   fi
}

function mkcd(){
   mkdir -p $1
   cd $1
}

function gitbranch(){
   git checkout -b $1
   git push -u origin HEAD
}

function linux(){
   if [ "$(uname 2> /dev/null)" = "Linux" ]; then
      return 0
   else
      return 1
   fi
}


# todo
function load(){

	if [[ -f $1 && -r $1 ]]; then
		source $1
	fi
}


load "$HOME/.zshrc-local"
