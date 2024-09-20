return {
	'nvim-treesitter/nvim-treesitter',
	priority = 51,
	config = function()
		local configs = require('nvim-treesitter.configs')

		configs.setup({
			ensure_installed = { 'c', 'lua', 'javascript', 'cpp', 'query', 'json', 'typescript', 'html', 'markdown' },
			sync_install = false,
			highlight = { enable = true },
			disable = function(lang)
				return lang == 'svelte'
			end,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<cr>',
					node_incremental = '<cr>', -- / scope_incremental
					node_decremental = '<space>'
				},
				is_supported = function()
					return vim.api.nvim_get_mode().mode ~= 'c'
				end
			}
		})
	end
}
