return function()
	local name = vim.fn.bufname()
	local buftype = vim.fn.getbufvar(name, '&buftype')

	if buftype == '' and name ~= '[Command Line]' then
		vim.cmd('bdelete')
	else
		vim.cmd('close')
	end
end

