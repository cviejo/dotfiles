local isValidWindow = function(win)
	return win and vim.api.nvim_win_is_valid(win)
end

-- Find existing sidebar.
local findOilWindow = function()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buffer = vim.api.nvim_win_get_buf(win)

		if vim.bo[buffer].filetype == 'oil' then
			return win
		end
	end
end

local setup = function(_, opts)
	local oil = require('oil')

	-- Open files in main window when sidebar is active.
	local onSelect = function()
		local entry = oil.get_cursor_entry()
		if not entry then
			return
		end

		local target_win = vim.w.oil_target_win

		if entry.type == 'directory' or not isValidWindow(target_win) then
			oil.select()
			return
		end

		oil.select({
			handle_buffer_callback = function(buffer)
				vim.api.nvim_set_current_win(target_win)
				vim.api.nvim_set_current_buf(buffer)
			end
		})
	end

	-- Override enter while preserving normal Oil behavior.
	opts.keymaps = { ['<CR>'] = { callback = onSelect, desc = 'Open entry in main window' } }
	oil.setup(opts)

	-- Open Oil in a persistent left sidebar.
	vim.api.nvim_create_user_command('OilSidebar', function()
		local oil_win = findOilWindow()
		if oil_win then
			vim.api.nvim_set_current_win(oil_win)
			return
		end

		-- Remember window where selected files should open.
		local target_win = vim.api.nvim_get_current_win()
		vim.cmd('topleft vertical split')
		local sidebar_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_width(sidebar_win, 30)
		vim.api.nvim_set_option_value('winfixwidth', true, { win = sidebar_win })
		vim.w[sidebar_win].oil_target_win = target_win
		oil.open()
	end, {})
end

return {
	'stevearc/oil.nvim',
	cond = vim.g.vscode ~= 1,
	opts = {
		default_file_explorer = true,
		view_options = { show_hidden = true },
		delete_to_trash = true
	},
	-- just remove the next line for the default setup
	config = setup
}
