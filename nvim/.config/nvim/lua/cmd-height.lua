local setTimeout = require('utils.set-timeout')

vim.opt.cmdheight = 0
vim.opt.laststatus = 0

local autcmd = function(event, fn)
	vim.api.nvim_create_autocmd(event, { pattern = '*', callback = fn })
end

autcmd('RecordingEnter', function()
	vim.opt_local.cmdheight = 1
end)

autcmd('RecordingLeave', function()
	setTimeout(function()
		vim.opt_local.cmdheight = 0
	end, 50)
end)
