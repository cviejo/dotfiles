local F = require('utils.functional')
local tmux = require('utils.tmux')
local buffer = require('utils.buffer')

local command = vim.api.nvim_create_user_command

local abbrev = function(from, to)
	vim.cmd('cnoreabbrev ' .. from .. ' ' .. to)
end

command('Qr', '.w !qrencode -o - -t UTF8 ', {})

command('TmuxVerticalSplit', tmux.verticalSplit, {})

command('TmuxHorizontalSplit', tmux.horizontalSplit, {})

command('CloseOtherBuffers', buffer.closeOther, {})

command('UseTabs', 'set noet ci pi sts=0 sw=3 ts=3', {})

abbrev('sw', 'ISwapNodeWithRight')

abbrev('swl', 'ISwapNodeWithLeft') -- probably not needed

abbrev('sws', 'ISwapWith')

abbrev('sws', 'ISwapWith')

abbrev('frm', 'CocCommand prettier.formatFile')

abbrev('frm', 'CocCommand prettier.formatFile')

abbrev('sjn', 'set filetype=json')

abbrev('sjs', 'set filetype=javascript')

abbrev('tmh', 'TmuxHorizontalSplit')

abbrev('tmv', 'TmuxVerticalSplit')

abbrev('focus', 'TZAtaraxis')

abbrev('z', 'TZAtaraxis')

abbrev('qaa', 'qa!')

F.forEach(function(x)
	abbrev(x:lower(), x)
end, { 'Note', 'Git', 'Gr', 'Gw', 'Qr', 'Qe', 'Qd' })
