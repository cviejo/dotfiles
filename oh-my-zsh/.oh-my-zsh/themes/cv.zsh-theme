# taken from https://github.com/chriskempson/base16-shell/issues/24
if [ -n "$TMUX" ]; then
	setColor() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
else
	setColor() { printf '\033]4;%d;rgb:%s\033\\' $@; }
fi

# ~/.local/share/nvim/site/pack/packer/start/catppuccin/lua/catppuccin/core/palettes/frappe.lua
rosewater="F2/D5/CF"
flamingo="EE/BE/BE"
pink="F4/B8/E4"
mauve="CA/9E/E6"
red="E7/82/84"
maroon="EA/99/9C"
peach="EF/9F/76"
yellow="E5/C8/90"
green="A6/D1/89"
teal="81/C8/BE"
sky="99/D1/DB"
sapphire="85/C1/DC" # 110
blue="8C/AA/EE"
lavender="BA/BB/F1"
text="C6/D0/F5"
subtext1="B5/BF/E2"
subtext0="A5/AD/CE"
overlay2="94/9C/BB"
overlay1="83/8B/A7"
overlay0="73/79/94"
surface2="62/68/80"
surface1="51/57/6D"
surface0="41/45/59"
base="30/34/46"
mantle="29/2C/3C"
crust="23/26/34"

setColor 000 $base     # black
setColor 002 $green    #
setColor 006 $teal     #
setColor 007 $overlay0 # silver
setColor 008 $surface1 # grey
setColor 009 $red      #
setColor 011 $yellow   #
setColor 012 $blue     #
setColor 014 $sky      # aqua
setColor 015 $text     # white
setColor 110 $sapphire #
setColor 235 $crust    # greys
setColor 238 $mantle   # greys
setColor 241 $surface0 # greys
setColor 244 $surface1 # greys
setColor 247 $surface2 # greys
setColor 250 $overlay0 # greys
setColor 252 $subtext0 # greys

currentBg='none'

prompt_segment() {
	local bg="%K{$1}"
	local fg="%F{$2}"
	if [[ $currentBg != 'none' && $1 != "$currentBg" ]]; then
		echo -n " %{$bg%F{$currentBg}%}%{$fg%} "
	else
		echo -n "%{$bg%}%{$fg%} "
	fi
	currentBg=$1
	[[ -n $3 ]] && echo -n "$3"
}

# close open segments
prompt_end() {
	if [[ -n $currentBg ]]; then
		echo -n " %{%k%F{$currentBg}%}"
	else
		echo -n "%{%k%}"
	fi
	echo -n "%{%f%}"
	currentBg=''
}

prompt_git() {
	# (($+commands[git])) || return
	local PL_BRANCH_CHAR='⎇'
	local ref dirty mode repo_path
	repo_path=$(git rev-parse --git-dir 2>/dev/null)

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		dirty=$(parse_git_dirty)
		ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="➦ $(git rev-parse --short HEAD 2>/dev/null)"
		if [[ -n $dirty ]]; then
			prompt_segment 002 000
		else
			prompt_segment 247 015
		fi

		if [[ -e "${repo_path}/BISECT_LOG" ]]; then
			mode=" <B>"
		elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
			mode=" >M<"
		elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
			mode=" >R>"
		fi

		setopt promptsubst
		autoload -Uz vcs_info

		zstyle ':vcs_info:*' enable git
		zstyle ':vcs_info:*' get-revision true
		zstyle ':vcs_info:*' check-for-changes true
		zstyle ':vcs_info:*' stagedstr '✚'
		zstyle ':vcs_info:*' unstagedstr '●'
		zstyle ':vcs_info:*' formats ' %u%c'
		zstyle ':vcs_info:*' actionformats ' %u%c'
		vcs_info
		echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
	fi
}

prompt_dir() {
	prompt_segment 238 015 '%~'
}

prompt_status() {
	local symbols=()
	[[ $RETVAL -ne 0 ]] && symbols+=("%{%F{red}%}x")             # - error
	[[ $UID -eq 0 ]] && symbols+=("%{%F{yellow}%}⚡")             # - root
	[[ $(jobs -l | wc -l) -gt 0 ]] && symbols+=("%{%F{cyan}%}⚙") # - background jobs
	[[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

# main
build_prompt() {
	RETVAL=$?
	prompt_git
	prompt_dir
	prompt_status
	prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
