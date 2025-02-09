vim.g.catppuccin_flavour = 'frappe'
-- light theme:
-- vim.g.catppuccin_flavour = 'latte'

local config = {
	integrations = {
		--
		treesitter = true,
		bufferline = true
	}
}

return {
	'catppuccin/nvim',
	name = 'catppuccin',
	priority = 51,
	lazy = false,
	config = function()
		vim.cmd('colorscheme catppuccin')
		require('catppuccin').setup(config)
	end
}
