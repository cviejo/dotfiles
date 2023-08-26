local F = require('utils.functional')
local buffer = require('utils.buffer')

local command = vim.api.nvim_create_user_command

local abbrev = function(from, to)
	vim.cmd('cnoreabbrev ' .. from .. ' ' .. to)
end

command('Qr', '.w !qrencode -o - -t UTF8 ', {})

command('TmuxVerticalSplit', function()
	local directory = vim.fn.expand('%:p:h')
	vim.fn.system('tmux split-window -h -c ' .. directory)
end, {})

command('CloseOtherBuffers', buffer.closeOther, {})

-- lowercase abbreviations of commands ---------
F.forEach(function(x)
	abbrev(x:lower(), x)
end, {'Note', 'Git', 'Gr', 'Gw', 'Qr', 'Qe', 'Qd'})

abbrev('sw', 'ISwapNodeWithRight')

abbrev('swl', 'ISwapNodeWithLeft') -- probably not needed

abbrev('sws', 'ISwapWith')

abbrev('sws', 'ISwapWith')

abbrev('frm', 'CocCommand prettier.formatFile')

abbrev('frm', 'CocCommand prettier.formatFile')

abbrev('jso', 'set filetype=json')

abbrev('jsc', 'set filetype=javascript')

abbrev('foc', 'TZAtaraxis')

abbrev('focus', 'TZAtaraxis')
