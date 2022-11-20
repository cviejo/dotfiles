local F = require('utils.functional')
local onBufLeave = require('utils.events').onBufLeave

local vscode = vim.g.vscode == 1

local devicons = 'kyazdani42/nvim-web-devicons'

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
	use 'rhysd/clever-f.vim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'
	use 'phaazon/hop.nvim'
	use 'junegunn/gv.vim'
	use 'mg979/vim-visual-multi'
	use 'neoclide/jsonc.vim'
	use 'meain/vim-printer'
	use 'mizlan/iswap.nvim'
	use 'numToStr/Comment.nvim'
	use 'uga-rosa/translate.nvim'

	use {'ziglang/zig.vim', disable = vscode}
	use {'jbyuki/venn.nvim', disable = vscode}
	use {'windwp/nvim-autopairs', disable = vscode}
	use {'arjunmahishi/run-code.nvim', disable = vscode}
	use {'jpalardy/vim-slime', disable = vscode}
	use {'/usr/local/opt/fzf', disable = vscode}
	use {'junegunn/fzf.vim', disable = vscode}
	use {'norcalli/nvim-colorizer.lua', disable = vscode}
	use {'sheerun/vim-polyglot', disable = vscode}
	use {'tpope/vim-fugitive', disable = vscode}
	use {'HiPhish/awk-ward.nvim', disable = vscode}
	use {'NicholasDunham/chuck.nvim', disable = vscode}
	use {'Pocco81/true-zen.nvim', disable = vscode, requires = {devicons}}
	use {'romgrk/barbar.nvim', disable = vscode, requires = {devicons}}
	use {"catppuccin/nvim", disable = vscode, tag = 'v0.2.2', as = "catppuccin"}
	use {'neoclide/coc.nvim', disable = vscode, branch = 'release'}
	use {'xolox/vim-notes', disable = vscode, requires = {'xolox/vim-misc'}}
	use {'nvim-lualine/lualine.nvim', disable = vscode, requires = {devicons, opt = true}}
	use {'styled-components/vim-styled-components', disable = vscode, branch = 'main'}

	-- evaluating:
	use 'RRethy/vim-illuminate'

	-- not ready for use yet:
	-- 'kylechui/nvim-surround'
	-- 'rcarriga/nvim-notify'
	-- 'phaazon/mind.nvim', -- this has a lot of potential, but no docs whatsoever
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
	fzf_colors = {
		border = { 'fg', 'VertSplit' }
	},
	fzf_layout = { down = '40%' },
	-- fzf_layout = {
	-- 	window = { width = 1, height = 0.4, yoffset = 0.99, border ='top' }
	-- },
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
	ensure_installed = {'c', 'lua', 'javascript', 'cpp', 'query', 'json'},
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

vim.g.deepl_api_auth_key = os.getenv("DEEPL_KEY")

require("translate").setup({default = {command = "deepl_free", output = 'replace'}})

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
		F.assign(vim.opt, {showmode = false, ruler = false})
		onBufLeave(function()
			F.assign(vim.opt, {showmode = true, ruler = true})
		end)
	end
})

vim.cmd('colorscheme catppuccin')

require('colorizer').setup()

require('true-zen').setup({
	modes = {
		ataraxis = {
			padding = {
				-- ok
				top = 5
			}
		},
		narrow = {folds_style = 'invisible'}
	},
	integrations = {tmux = true, lualine = true}
})

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
