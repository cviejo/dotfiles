local winrestcmd = nil

return function()
	if winrestcmd then
		vim.cmd(winrestcmd)
		winrestcmd = nil
	else
		winrestcmd = vim.fn.winrestcmd()
		vim.cmd('resize')
		vim.cmd('vertical resize')
	end
end

