local cmd, fn = vim.cmd, vim.fn

local getVar = function(x, bufname)
	return fn.getbufvar(bufname or fn.bufname(), '&' .. x)
end

local close = function()
	local name = fn.bufname()
	local buftype = getVar('buftype', name)

	if buftype == '' and name ~= '[Command Line]' then
		cmd('bdelete')
	else
		cmd('close')
	end
end

local closeOther = function()
	cmd('norm mb')
	cmd('silent! exe "%bd|e#|bd#"')
	cmd('norm `b')
end

return {close = close, closeOther = closeOther, getVar = getVar}
