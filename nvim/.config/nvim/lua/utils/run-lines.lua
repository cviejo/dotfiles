local F = require('utils.functional')

local join = F.join
local format = string.format
local getline, expand, system = vim.fn.getline, vim.fn.expand, vim.fn.system

local echo = function(txt)
	vim.api.nvim_echo({{txt}}, false, {})
end

return function(from, to, bin)
	local lines = getline(from, to)
	local command = format(bin .. " <<-EOF\n%s\nEOF", join('\n', lines))

	echo(system('cd ' .. expand('%:p:h') .. ' && ' .. command))
end

