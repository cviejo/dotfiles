local F = require('utils.functional')
local buffer = require('utils.buffer')

local command = vim.api.nvim_create_user_command

local expand, system = vim.fn.expand, vim.fn.system

command('Qr', '.w !qrencode -o - -t UTF8 ', {})

command('TmuxVerticalSplit', function()
	system('tmux split-window -h -c ' .. expand('%:p:h'))
end, {})

command('CloseOtherBuffers', buffer.closeOther, {})

-- lowercase abbreviations of commands ---------
F.forEach(function(x)
	vim.cmd('cnoreabbrev ' .. x:lower() .. ' ' .. x)
end, {'Note', 'Goyo', 'Gr', 'Gw', 'Qr', 'Qe', 'Qd'})

vim.cmd('cnoreabbrev sw ISwapWith')

