local F = require('utils.functional')
local tmux = require('utils.tmux')
local buffer = require('utils.buffer')

local command = vim.api.nvim_create_user_command

local abbrev = function(from, to)
	vim.cmd('cnoreabbrev ' .. from .. ' ' .. to)
end

local function localBin(name)
	local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))

	while dir do
		local bin = vim.fs.joinpath(dir, 'node_modules', '.bin', name)
		if vim.fn.executable(bin) == 1 then
			return bin
		end

		local parent = vim.fs.dirname(dir)
		if parent == dir then
			break
		end
		dir = parent
	end
end

local function format()
	local prettierFiletypes = {
		css = true,
		html = true,
		javascript = true,
		javascriptreact = true,
		json = true,
		jsonc = true,
		markdown = true,
		svelte = true,
		typescript = true,
		typescriptreact = true,
		yaml = true
	}

	if prettierFiletypes[vim.bo.filetype] then
		local prettier = localBin('prettier')
		if not prettier then
			vim.notify('No local prettier found', vim.log.levels.WARN)
			return
		end

		vim.cmd.write()
		vim.system({ prettier, '--write', vim.api.nvim_buf_get_name(0) }, { text = true }, function(result)
			vim.schedule(function()
				if result.code == 0 then
					vim.cmd.edit()
				else
					vim.notify(result.stderr, vim.log.levels.ERROR)
				end
			end)
		end)
		return
	end

	vim.lsp.buf.format({ async = true })
end

command('Qr', '.w !qrencode -o - -t UTF8 ', {})

command('TmuxVerticalSplit', tmux.verticalSplit, {})

command('TmuxHorizontalSplit', tmux.horizontalSplit, {})

command('CloseOtherBuffers', buffer.closeOther, {})

command('UseTabs', 'set noet ci pi sts=0 sw=3 ts=3', {})

command('Format', format, {})

abbrev('sw', 'ISwapNodeWithRight')

abbrev('swl', 'ISwapNodeWithLeft') -- probably not needed

abbrev('sws', 'ISwapWith')

abbrev('sws', 'ISwapWith')

abbrev('frm', 'Format')

abbrev('sjn', 'set filetype=json')

abbrev('sjs', 'set filetype=javascript')

abbrev('tmh', 'TmuxHorizontalSplit')

abbrev('tmv', 'TmuxVerticalSplit')

abbrev('focus', 'TZAtaraxis')

abbrev('z', 'TZAtaraxis')

abbrev('qaa', 'qa!')

abbrev('qq', 'qa!')

F.forEach(function(x)
	abbrev(x:lower(), x)
end, { 'Note', 'Git', 'Gr', 'Gw', 'Qr', 'Qe', 'Qd' })
