local F = require('utils.functional')
local onBufLeave = require('utils.events').onBufLeave

local devicons = 'kyazdani42/nvim-web-devicons'

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tomtom/tcomment_vim'
	use 'tpope/vim-surround'
	use 'rhysd/clever-f.vim'
	use {"catppuccin/nvim", as = "catppuccin"}
	use 'nvim-treesitter/nvim-treesitter'
	use 'norcalli/nvim-colorizer.lua'
	use {'romgrk/barbar.nvim', requires = {devicons}}
	use 'phaazon/hop.nvim'
	use 'jiangmiao/auto-pairs'
	use 'jpalardy/vim-slime'
	use '/usr/local/opt/fzf'
	use 'junegunn/fzf.vim'
	use 'junegunn/goyo.vim'
	use 'junegunn/gv.vim'
	use 'mg979/vim-visual-multi'
	use {'neoclide/coc.nvim', branch = 'release'}
	use 'sheerun/vim-polyglot'
	use {'styled-components/vim-styled-components', branch = 'main'}
	use 'tpope/vim-fugitive'
	use 'xolox/vim-notes'
	use 'xolox/vim-misc'
	use 'neoclide/jsonc.vim'
	use 'HiPhish/awk-ward.nvim'
	use 'NicholasDunham/chuck.nvim'
	use 'styled-components/vim-styled-components'
	use 'arjunmahishi/run-code.nvim'
	use {'nvim-lualine/lualine.nvim', requires = {devicons, opt = true}}
end)

-- LuaFormatter off
F.assign(vim.g, {
	-- ~/.local/share/nvim/site/pack/packer/start/catppuccin/lua/catppuccin/core/palettes/frappe.lua
	catppuccin_flavour = "frappe",
	coc_global_extensions = {
		'coc-diagnostic',
		'coc-eslint',
		'coc-explorer',
		'coc-git',
		'coc-json',
		'coc-lua',
		'coc-prettier',
		'coc-rls',
		'coc-snippets',
		'coc-svelte',
		'coc-tsserver',
		'https://github.com/nathanchapman/vscode-javascript-snippets'
	},
	coc_snippet_next = '<tab>',
	fzf_layout = {
		down = '50%'
	},
	notes_word_boundaries = 1,
	slime_default_config = {
		target_pane = '{next}',
		socket_name = 'default'
	},
	slime_dont_ask_default = 1,
	slime_target = "tmux"
})
-- LuaFormatter on

vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = {'fzf'},
	callback = function()
		F.assign(vim.opt, {laststatus = 0, showmode = false, ruler = false})
		onBufLeave(function()
			F.assign(vim.opt, {laststatus = 2, showmode = true, ruler = true})
		end)
	end
})

vim.cmd([[
function SlimeOverride_EscapeText_javascript(text)
	let cmd = "awk '{ gsub(/\\s*(const|let)\\s*/, \" var \"); r=r$0\"\"; } END { print r\"\\n\"; }'"
	return system(cmd, a:text)
endfunction
]])

vim.cmd('colorscheme catppuccin')

require('colorizer').setup()

require('bufferline').setup({
	tabpages = true,
	animation = false,
	closable = false,
	maximum_padding = 1,
	icon_separator_active = '',
	icon_separator_inactive = '',
	add_in_buffer_number_order = false
})

require('lualine').setup({
	options = {theme = "catppuccin", section_separators = {left = "", right = ""}}
})

require('hop').setup({keys = 'asdfjkl;weiocmr'})

require("catppuccin").setup({
	integrations = {treesitter = true, bufferline = true}
})

require('nvim-treesitter.configs').setup({
	ensure_installed = {'c', 'lua', 'javascript', 'cpp', 'svelte'},
	sync_install = false,
	highlight = {enable = true}
})

require('run-code').setup({
	output = {buffer = true, split_cmd = '20split'},
	enable_custom_commands = false
})
