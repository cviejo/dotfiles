#! /bin/zsh

printMenu(){
	menu=(show pop apply drop back exit)
	printf '%s\n' "${menu[@]}"
}

run(){
	if [ -z "$1" ]; then
		entry=$(git stash list | fzf --layout=reverse --info=hidden)
	else
		entry=$1
	fi

	cmd=$(printMenu | fzf --layout=reverse --info=hidden --header "entry: $entry")

	if [[ $cmd == back ]]; then
		run
	elif [[ $cmd == show ]]; then
		echo $entry | awk 'sub(/:.*/, "")' | xargs git stash show -p
		run $entry
	elif [[ $cmd != 'exit' ]]; then
		echo $entry | awk 'sub(/:.*/, "")' | xargs git stash $cmd
	fi
}

run
