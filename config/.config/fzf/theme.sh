#! /bin/bash

_gen_fzf_default_opts() {

	# theme (catppuccin frappe)
	local rosewater="#F2D5CF"
	local flamingo="#EEBEBE"
	local pink="#F4B8E4"
	local mauve="#CA9EE6"
	local red="#E78284"
	local maroon="#EA999C"
	local peach="#EF9F76"
	local yellow="#E5C890"
	local green="#A6D189"
	local teal="#81C8BE"
	local sky="#99D1DB"
	local sapphire="#85C1DC"
	local blue="#8CAAEE"
	local lavender="#BABBF1"
	local text="#C6D0F5"
	local subtext1="#B5BFE2"
	local subtext0="#A5ADCE"
	local overlay2="#949CBB"
	local overlay1="#838BA7"
	local overlay0="#737994"
	local surface2="#626880"
	local surface1="#51576D"
	local surface0="#414559"
	local base="#303446"
	local mantle="#292C3C"
	local crust="#232634"

	export FZF_DEFAULT_OPTS="
		--color=bg+:$crust,bg:$base,spinner:$rosewater,hl:$red
		--color=fg:$subtext0,header:$maroon,info:$mauve,pointer:$flamingo
		--color=marker:$maroon,fg+:$rosewater,prompt:$mauve,hl+:$red
		--color=gutter:$base
		--border=none
		--preview-window border-none
	"
}

# # temp fzf theme (TODO: add catpuccin to ~/.config/fzf/base16-ocean.config)
# # -------------------------------------------------------------
# export FZF_DEFAULT_OPTS="
# 	--color=bg+:#302D41,spinner:#F8BD96,hl:#F28FAD
# 	--color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96
# 	--color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD
# "

_gen_fzf_default_opts
