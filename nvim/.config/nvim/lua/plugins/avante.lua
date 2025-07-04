local dependencies = {
	-- LuaFormatter off
	'stevearc/dressing.nvim',
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	-- for providers='copilot':
	-- 'zbirenbaum/copilot.lua', 
	-- LuaFormatter on
		{
			-- support for image pasting
			'HakonHarnes/img-clip.nvim',
			event = 'VeryLazy',
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					-- required for Windows users
					use_absolute_path = true
				}
			}
		}, {
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = { file_types = { 'markdown', 'Avante' } },
			ft = { 'markdown', 'Avante' }
		}
}

local opts = {
	--
	provider = 'gemini',
	gemini = { model = 'gemini-2.5-pro-preview-05-06' },
	mappings = {
		ask = '<leader>ua', -- ask
		edit = '<leader>ue', -- edit
		refresh = '<leader>ur' -- refresh
	}
}

return {
	'yetone/avante.nvim',
	event = 'VeryLazy',
	cond = false,
	lazy = false,
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = 'make BUILD_FROM_SOURCE=true',
	opts = opts,
	dependencies = dependencies
}
