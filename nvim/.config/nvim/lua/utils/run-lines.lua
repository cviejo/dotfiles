local F = require('utils.functional')

local bins = {
	javascript = 'node',
	typescript = 'ts-node',
	javascriptreact = 'node',
	typescriptreact = 'ts-node',
	lua = 'lua',
	python = 'python3',
	sh = 'bash',
	zsh = 'zsh',
	bash = 'bash',
	ruby = 'ruby'
}

local function echo(msg)
	vim.api.nvim_echo({ { '\n' .. msg } }, true, {})
end

return function(from, to, bin)
	bin = bin or bins[vim.bo.filetype]
	if not bin then
		echo('no runner for filetype: ' .. vim.bo.filetype)
		return
	end
	local input = F.join('\n', vim.fn.getline(from, to))

	echo(vim.fn.system(bin .. ' 2>&1', input))
end
