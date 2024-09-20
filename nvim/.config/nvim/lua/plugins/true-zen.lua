local devicons = 'nvim-tree/nvim-web-devicons'

local notVsCode = vim.g.vscode ~= 1

local config = {
	modes = {
		ataraxis = {
			padding = {
				--
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
