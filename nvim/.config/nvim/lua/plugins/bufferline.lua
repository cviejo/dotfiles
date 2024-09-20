local devicons = 'nvim-tree/nvim-web-devicons'

local config = {
	-- closable = false,
	tabpages = true,
	animation = false,
	maximum_padding = 1,
	icons = {
		button = '',
		modified = { buton = '' },
		inactive = { left = '', right = '', button = '' },
		separator = { left = '', right = '' }
	},
	add_in_buffer_number_order = false
}

return {
	'romgrk/barbar.nvim',
	dependencies = { devicons },
	config = function()
		require('bufferline').setup(config)
	end
}

