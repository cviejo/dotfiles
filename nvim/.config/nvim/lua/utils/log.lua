local buffer = require('utils.buffer')

local fillLog = 'norm F"Plllp`b'

local log = function(yankCommand)
	local filetype = buffer.getVar('filetype')

	if filetype == nil or filetype == 'javascript' then
		vim.cmd(yankCommand .. 'console.log("", );')
		vim.cmd(fillLog)
	elseif filetype == 'lua' then
		vim.cmd(yankCommand .. 'print("", );')
		vim.cmd(fillLog)
	end
end

local underCursor = function()
	log('norm mbyiwo')
end

local selection = function()
	log('norm mbyo')
	vim.cmd('norm gv')
end

return {underCursor = underCursor, selection = selection}

-- usage
-- map('n', '<leader>l', log.underCursor)
-- map('v', '<leader>l', log.selection)
-- for now using vim-printer instead
