require('options')
require('lazy-init')
require('commands')
require('keymap')
require('cmd-height')

local api = vim.api

api.nvim_command('autocmd TermOpen * startinsert')             -- starts in insert mode
api.nvim_command('autocmd TermOpen * setlocal nonumber')       -- no numbers
api.nvim_command('autocmd TermEnter * setlocal signcolumn=no') -- no sign column

-- by default start a javascript buffer
vim.api.nvim_create_autocmd('BufWinEnter', {
	pattern = '*',
	callback = function()
		if vim.fn.expand('%:e') == 'ck' then
			vim.bo.filetype = 'chuck'
		elseif vim.bo.filetype == '' then
			vim.bo.filetype = 'javascript'
		end
	end
})
