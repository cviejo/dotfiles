local F = require('utils.functional')
local onBufLeave = require('utils.events').onBufLeave

local vscode = vim.g.vscode == 1

local devicons = 'kyazdani42/nvim-web-devicons'

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
	use 'rhysd/clever-f.vim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'phaazon/hop.nvim'
	use 'junegunn/gv.vim'
	use 'mg979/vim-visual-multi'
	use 'neoclide/jsonc.vim'
	use 'meain/vim-printer'
	use 'mizlan/iswap.nvim'
	use 'numToStr/Comment.nvim'

	use {'romgrk/barbar.nvim', requires = {devicons}}
	use {'ziglang/zig.vim', disable = vscode}
	use {'jbyuki/venn.nvim', disable = vscode}
	use {'windwp/nvim-autopairs', disable = vscode}
	use {'arjunmahishi/run-code.nvim', disable = vscode}
	use {'jpalardy/vim-slime', disable = vscode}
	use {'/usr/local/opt/fzf', disable = vscode}
	use {'junegunn/fzf.vim', disable = vscode}
	use {'junegunn/goyo.vim', disable = vscode}
	use {'norcalli/nvim-colorizer.lua', disable = vscode}
	use {'sheerun/vim-polyglot', disable = vscode}
	use {'tpope/vim-fugitive', disable = vscode}
	use {'HiPhish/awk-ward.nvim', disable = vscode}
	use {'NicholasDunham/chuck.nvim', disable = vscode}
	use {"catppuccin/nvim", as = "catppuccin", disable = vscode}
	use {'neoclide/coc.nvim', branch = 'release', disable = vscode}
	use {'xolox/vim-notes', requires = {'xolox/vim-misc'}, disable = vscode}
	use {'nvim-lualine/lualine.nvim', requires = {devicons, opt = true}, disable = vscode}
	use {'styled-components/vim-styled-components', branch = 'main', disable = vscode}

	-- not ready yet:
	-- use 'Pocco81/true-zen.nvim'
	-- use 'kylechui/nvim-surround'
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
-- LuaFormatter on

require('nvim-treesitter.configs').setup({
	ensure_installed = {'c', 'lua', 'javascript', 'cpp'},
	sync_install = false,
	highlight = {enable = true},
	disable = function(lang)
		return lang == 'svelte'
	end,
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<cr>',
			node_incremental = '<cr>', -- / scope_incremental
			node_decremental = '<space>'
		}
	}
})

require('hop').setup({keys = 'asdfjkl;weiocmr'})

require('iswap').setup({flash_style = 'none', autoswap = true, hl_snipe = 'ErrorMsg'})

require('Comment').setup({mappings = false})

if vscode then
	return
end

-- replace all const and lets with vars so that we can resend the same chunk
_G.slimeEscapeJavascript = function(x)
	return x:gsub('const[%s]+', 'var '):gsub('let[%s]+', 'var '):gsub('[%s]+%.', '.')
end

vim.cmd([[
function SlimeOverride_EscapeText_javascript(text)
	return v:lua.slimeEscapeJavascript(a:text)
endfunction
]])

vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = {'fzf'},
	callback = function()
		F.assign(vim.opt, {laststatus = 0, showmode = false, ruler = false})
		onBufLeave(function()
			F.assign(vim.opt, {laststatus = 2, showmode = true, ruler = true})
		end)
	end
})

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

require("catppuccin").setup({integrations = {treesitter = true, bufferline = true}})

require('run-code').setup({
	output = {buffer = true, split_cmd = '20split'},
	enable_custom_commands = false
})

require('nvim-autopairs').setup({disable_in_macro = true})

require('utils.venn')
