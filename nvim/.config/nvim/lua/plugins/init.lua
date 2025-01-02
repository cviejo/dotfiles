local F = require('utils.functional')

vim.g.deepl_api_auth_key = os.getenv('DEEPL_KEY')

vim.g.notes_word_boundaries = 1

-- LuaFormatter off
vim.g.vim_printer_items = {
	chuck = '<<< "{$}:", {$} >>>;',
	lua = 'print("{$}: ", {$})'
}

-- run on both neovim and vscode
local alwaysOn = {
	{ 'nvim-treesitter/playground' },
	{ 'tpope/vim-surround' },
	{ 'rhysd/clever-f.vim' },
	{ 'junegunn/gv.vim' },
	{ 'mg979/vim-visual-multi' },
	{ 'neoclide/jsonc.vim' },
	{ 'meain/vim-printer' },
	{ 'tpope/vim-fugitive' },
	{ 'phaazon/hop.nvim', opts = { keys = 'asdfjkl;weiocmr' } },
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
	-- evaluating:
	{ 'OXY2DEV/markview.nvim', cond = false },
	{ 'chrisgrieser/nvim-chainsaw', cond = false },
	{ 'epwalsh/obsidian.nvim', cond = false },
	{ 'vimwiki/vimwiki', cond = false },
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = true,
		cond = false
	},
	{
		"RutaTang/quicknote.nvim",
		cond = false,
		config = function()
			require("quicknote").setup({})
		end,
		dependencies = { "nvim-lua/plenary.nvim" }
	}
}

-- don't run on vscode
local notVsCode = {
	{ 'sheerun/vim-polyglot' },
	{ 'github/copilot.vim' },
	{ 'norcalli/nvim-colorizer.lua', opts = {} },
	{ 'windwp/nvim-autopairs', opts = { disable_in_macro = true } },
	{ 'xolox/vim-notes', dependencies = { 'xolox/vim-misc' } },
	{ 'styled-components/vim-styled-components', branch = 'main' },
	{ 'NicholasDunham/chuck.nvim', lazy = false },
	-- {
	--  "gacallea/chuck-nvim",
	--  version = "*",
	--  dependencies = {
	--    { "MunifTanjim/nui.nvim" },
	--    { -- until https://github.com/gacallea/chuck-nvim/issues/3
	--      "nvim-tree/nvim-web-devicons",
	--      opts = {
	--        override_by_extension = {
	--          ["ck"] = {
	--            icon = "󰧚",
	--            color = "#80ff00",
	--            name = "ChucK",
	--          },
	--        },
	--      },
	--    },
	--  },
	--  ft = { "chuck" },
	-- },
	{
		'stevearc/oil.nvim',
		opts = {
			default_file_explorer = true,
			view_options = { show_hidden = true },
			delete_to_trash = true
		}
	},
	-- evaluating:
	{ 'RRethy/vim-illuminate' },
}
-- LuaFormatter on

F.forEach(function(plugin)
	plugin.cond = vim.g.vscode ~= 1
end, notVsCode)

return F.concat(alwaysOn, notVsCode)

-- not installed yet:
-- https://github.com/nvim-orgmode/orgmode
-- https://github.com/serenevoid/kiwi.nvim
