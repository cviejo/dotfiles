local notVsCode = vim.g.vscode ~= 1

vim.g.deepl_api_auth_key = os.getenv('DEEPL_KEY')
vim.g.notes_word_boundaries = 1

-- LuaFormatter off
vim.g.vim_printer_items = {
	chuck = '<<< "{$}:", {$} >>>;',
	lua = 'print("{$}: ", {$})'
}

return {
	{ 'nvim-treesitter/playground' },
	{ 'tpope/vim-surround' },
	{ 'rhysd/clever-f.vim' },
	{ 'junegunn/gv.vim' },
	{ 'mg979/vim-visual-multi' },
	{ 'neoclide/jsonc.vim' },
	{ 'meain/vim-printer' },
	{ 'tpope/vim-fugitive', },
	{
		'phaazon/hop.nvim',
		opts = { keys = 'asdfjkl;weiocmr' }
	},
	{
		'mizlan/iswap.nvim',
		opts = { flash_style = 'none', autoswap = true, hl_snipe = 'ErrorMsg' }
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup({ mappings = false })
			require('Comment.ft').set('chuck', { '//%s', '/*%s*/' })
		end
	},
	{
		'uga-rosa/translate.nvim',
		opts = { default = { command = 'deepl_free', output = 'replace' } }
	},

	-- disabled in vscode:
	{
		'NicholasDunham/chuck.nvim',
		cond = notVsCode,
		lazy = false
	},
	{
		'windwp/nvim-autopairs',
		cond = notVsCode,
		opts = { disable_in_macro = true
	}
	},
	{
		'sheerun/vim-polyglot',
		cond = notVsCode
	},
	{
		'stevearc/oil.nvim',
		cond = notVsCode,
		opts = {
			default_file_explorer = true,
			view_options = { show_hidden = true },
			delete_to_trash = true
		}
	},
	{ 'github/copilot.vim',                      cond = notVsCode },
	{ 'norcalli/nvim-colorizer.lua',             cond = notVsCode, opts = {} },
	{ 'xolox/vim-notes',                         cond = notVsCode, dependencies = { 'xolox/vim-misc' } },
	{ 'styled-components/vim-styled-components', cond = notVsCode, branch = 'main' },


	-- evaluating:
	{ 'RRethy/vim-illuminate' },
	{ 'OXY2DEV/markview.nvim',                   cond = false },
	{ 'chrisgrieser/nvim-chainsaw',              cond = false },
	{ 'epwalsh/obsidian.nvim',                   cond = false },
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = true,
		cond = false
	},
	{ 'vimwiki/vimwiki', cond = false },
	{
		"RutaTang/quicknote.nvim",
		cond = false,
		config = function()
			-- you must call setup to let quicknote.nvim works correctly
			require("quicknote").setup({})
		end,
		dependencies = { "nvim-lua/plenary.nvim" }
	}

	-- not installed yet:
	-- https://github.com/nvim-orgmode/orgmode
	-- https://github.com/serenevoid/kiwi.nvim
}
-- LuaFormatter on
