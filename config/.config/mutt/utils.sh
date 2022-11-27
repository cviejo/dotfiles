#!/usr/bin/env bash

mutttmp=/tmp/mutt
rangerPick=$mutttmp/ranger-pick
muttPick=$mutttmp/pick

cleanup() {
	rm -f $mutttmp/*
}

pick() {
	ranger --choosefiles $rangerPick
	if [[ -f "$rangerPick" ]]; then
		awk '
			BEGIN {
				printf("push ");
			} {
				printf("<attach-file>"$0"<enter>");
			}
		' $rangerPick >$muttPick
	fi
	rm -f $rangerPick
}

(
	mkdir -p $mutttmp
	cd $mutttmp || exit

	if [[ $1 == pick ]]; then
		cleanup
		pick
	elif [[ $1 == open ]]; then
		find . -type f ! -name "index.html" | awk 'system("mv "$0" "gensub(/index.html/, "", 1))'
		open "$(ls)"
	elif [[ $1 == print-cmd ]]; then
		echo "<shell-escape>bash $HOME/.config/mutt/utils.sh $2<enter>"
	elif [[ $1 == clean ]]; then
		cleanup
	fi
)
