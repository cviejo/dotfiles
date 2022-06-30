local F = require('utils.functional')
local onBufLeave = require('utils.events').onBufLeave

local devicons = 'kyazdani42/nvim-web-devicons'

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tomtom/tcomment_vim'
	use 'tpope/vim-surround'
	use 'rhysd/clever-f.vim'
	use 'nvim-treesitter/nvim-treesitter'
	use {'romgrk/barbar.nvim', requires = {devicons}}
	use 'phaazon/hop.nvim'
	use 'jiangmiao/auto-pairs'
	use 'jpalardy/vim-slime'
	use '/usr/local/opt/fzf'
	use 'junegunn/fzf.vim'
	use 'junegunn/gv.vim'
	use 'mg979/vim-visual-multi'
	use 'neoclide/jsonc.vim'
	use 'arjunmahishi/run-code.nvim'
	use 'meain/vim-printer'

	if vim.g.vscode then
		return
	end
	use 'HiPhish/awk-ward.nvim'
	use 'NicholasDunham/chuck.nvim'
	use 'junegunn/goyo.vim'
	use 'norcalli/nvim-colorizer.lua'
	use 'sheerun/vim-polyglot'
	use 'tpope/vim-fugitive'
	use {"catppuccin/nvim", as = "catppuccin"}
	use {'neoclide/coc.nvim', branch = 'release'}
	use {'nvim-lualine/lualine.nvim', requires = {devicons, opt = true}}
	use {'styled-components/vim-styled-components', branch = 'main'}
	use {'xolox/vim-notes', requires = {'xolox/vim-misc'}}
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
		'coc-yaml',
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

_G.slimeEscapeJavascript = function(x)
	return x:gsub('const[%s]+', 'var '):gsub('let[%s]+', 'var '):gsub('[%s]+%.', '.')
end
-- LuaFormatter on

vim.cmd([[
function SlimeOverride_EscapeText_javascript(text)
	return v:lua.slimeEscapeJavascript(a:text)
endfunction
]])

vim.cmd('colorscheme catppuccin')

vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = {'fzf'},
	callback = function()
		F.assign(vim.opt, {laststatus = 0, showmode = false, ruler = false})
		onBufLeave(function()
			F.assign(vim.opt, {laststatus = 2, showmode = true, ruler = true})
		end)
	end
})

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
