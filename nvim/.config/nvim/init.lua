require('keymap')
require('options')
require('plugins')

local F = require('utils.functional')

local env = vim.fn.getenv('color')
print("env", vim.inspect(env));

-- lowercase abbreviations ------------------------------------
F.forEach(function(x)
	vim.cmd('cnoreabbrev ' .. string.lower(x) .. ' ' .. x)
end, {'Note', 'Goyo', 'Gr', 'Gw', 'Qr', 'Qe', 'Qd'})

local colors = require('catppuccin.api.colors').get_colors()

-- vim.pretty_print(colors)
