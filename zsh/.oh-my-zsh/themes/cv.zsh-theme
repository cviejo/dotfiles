# taken from https://github.com/chriskempson/base16-shell/issues/24
if [ -n "$TMUX" ]; then
	printf_template='\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\'
else
	printf_template='\033]4;%d;rgb:%s\033\\'
fi

# bg
printf $printf_template 000 "2B/30/3B"

# vim bar light
printf $printf_template 239 "4F/5B/66"

# vim bar dark
printf $printf_template 237 "34/3D/46"

# silver / greys
printf $printf_template 007 "C0/C5/CE"
printf $printf_template 008 "4F/5B/66"
printf $printf_template 236 "2B/30/3B"
printf $printf_template 251 "C0/C5/CE"

# green > pale green (114)
printf $printf_template 002 "99/C7/94"


currentBg='none'

# two optional arguments: bg and fg
prompt_segment() {
	local bg fg
	[[ -n $1 ]] && bg="%K{$1}" || bg="%k"
	[[ -n $2 ]] && fg="%F{$2}" || fg="%f"
	if [[ $currentBg != 'none' && $1 != $currentBg ]]; then
		echo -n " %{$bg%F{$currentBg}%}%{$fg%} "
	else
		echo -n "%{$bg%}%{$fg%} "
	fi
	currentBg=$1
	[[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
	if [[ -n $currentBg ]]; then
		echo -n " %{%k%F{$currentBg}%}"
	else
		echo -n "%{%k%}"
	fi
	echo -n "%{%f%}"
	currentBg=''
}

# context: user@hostname (who am I and where am I)
prompt_context() {
	if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
		prompt_segment 114 236	"%(!.%{%F{yellow}%}.)$USER@%m"
	fi
}

# git: branch/detached head, dirty status
prompt_git() {
	(( $+commands[git] )) || return
	local PL_BRANCH_CHAR
	() {
		local LC_ALL="" LC_CTYPE="en_US.UTF-8"
		PL_BRANCH_CHAR=$'\ue0a0' # 
		PL_BRANCH_CHAR=$'⎇' # 
	}
	local ref dirty mode repo_path
	repo_path=$(git rev-parse --git-dir 2>/dev/null)

	if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
		dirty=$(parse_git_dirty)
		ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
		if [[ -n $dirty ]]; then
			prompt_segment 114 236
		else
			prompt_segment 239 251
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

# dir: current working directory
prompt_dir() {
	prompt_segment 237 251 '%~'
}

# status:
# - error
# - root
# - background jobs
prompt_status() {
	local symbols
	symbols=()
	[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}x"
	[[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
	[[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

	[[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

# main
build_prompt() {
	RETVAL=$?
	# prompt_context
	prompt_git
	prompt_dir
	prompt_status
	prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
