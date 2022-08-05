local F = require('utils.functional')

local M = {}

M.getCurrentLine = vim.api.nvim_get_current_line

M.getCursor = function(win)
	return vim.api.nvim_win_get_cursor(win or 0)
end

M.getCol = function()
	return M.getCursor()[2] + 1
end

M.getLineNr = function()
	return M.getCursor()[1]
end

M.getCurrentChar = function()
	local col = M.getCol()
	return M.getCurrentLine():sub(col, col)
end

M.replaceTermCodes = function(x)
	return vim.api.nvim_replace_termcodes(x, true, true, true)
end

M.feedkeys = F.pipe(M.replaceTermCodes, vim.fn.feedkeys)

return M
