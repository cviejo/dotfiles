local M = {}

-- LuaFormatter off
M.onBufLeave = function(callback)
	vim.api.nvim_create_autocmd({"BufLeave"}, {
		pattern = {'<buffer>'},
		callback = callback
	})
end
-- LuaFormatter on

return M
