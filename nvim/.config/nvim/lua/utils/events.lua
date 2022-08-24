local M = {}

local on = vim.api.nvim_create_autocmd

M.getBufType = function(id)
	return vim.api.nvim_buf_get_option(id or 0, 'buftype')
end

M.onBufLeave = function(callback)
	on("BufLeave", {pattern = {'<buffer>'}, callback = callback})
end

M.onTermOpen = function(callback)
	on("TermOpen", {
		pattern = "*",
		callback = function()
			-- Wait briefly just in case we immediately switch out of the buffer
			vim.defer_fn(function()
				if M.getBufType() == 'terminal' then
					callback()
				end
			end, 100)
		end
	})
end

M.onTermOpen(function()
	print('ahem')
	vim.cmd([[startinsert]])
end)

return M
