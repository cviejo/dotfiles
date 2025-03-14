local devicons = 'nvim-tree/nvim-web-devicons'

local notVsCode = vim.g.vscode ~= 1

local config = {
	modes = {
		ataraxis = {
			minimum_writing_area = { -- minimum size of main window
				width = 100
			},
			padding = {
				--
				-- left = 32,
				-- right = 32,
				top = 5
			}
		},
		narrow = { folds_style = 'invisible' }
	},
	integrations = { tmux = true }
}

return {
	'Pocco81/true-zen.nvim',
	cond = notVsCode,
	config = function()
		require('true-zen').setup(config)
	end,
	dependencies = { devicons }
}
