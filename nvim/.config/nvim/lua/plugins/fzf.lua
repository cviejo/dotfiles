local F = require('utils.functional')
local onBufLeave = require('utils.events').onBufLeave

vim.g.fzf_colors = { border = { 'fg', 'VertSplit' } }
vim.g.fzf_layout = { down = '40%' }

-- fzf_layout = { window = { width = 1, height = 0.4, yoffset = 0.99, border ='top' } },

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'fzf' },
	callback = function()
		F.assign(vim.opt, { showmode = false, ruler = false })
		onBufLeave(function()
			F.assign(vim.opt, { showmode = true, ruler = true })
		end)
	end
})

return { { 'junegunn/fzf' }, { 'junegunn/fzf.vim' } }
