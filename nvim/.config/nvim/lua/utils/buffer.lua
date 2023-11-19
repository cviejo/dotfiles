local M = {}

local cmd, fn = vim.cmd, vim.fn

M.getVar = function(x, bufname)
	return fn.getbufvar(bufname or fn.bufname(), '&' .. x)
end

M.getDirectory = function()
	return fn.expand('%:p:h')
end

M.close = function()
	local name = fn.bufname()
	local buftype = M.getVar('buftype', name)

	if buftype == '' and name ~= '[Command Line]' then
		cmd('bdelete')
	elseif buftype == 'acwrite' then
		cmd('bdelete')
	else
		cmd('close')
	end
end

M.closeOther = function()
	cmd('norm mb')
	cmd('silent! exe "%bd|e#|bd#"')
	cmd('norm `b')
end

return M
