local map = function(mode, from, to)
	vim.api.nvim_buf_set_keymap(0, mode, from, to, {noremap = true})
end

-- venn.nvim: enable or disable keymappings
_G.ToggleVenn = function()
	if vim.b.venn then
		vim.b.venn = nil
		vim.cmd('setlocal virtualedit=')
		vim.cmd('mapclear <buffer>')
	else
		vim.b.venn = true
		vim.cmd('setlocal virtualedit=all')
		-- draw a line on HJKL keystokes
		map("n", "J", "<C-v>j:VBox<cr>")
		map("n", "K", "<C-v>k:VBox<cr>")
		map("n", "L", "<C-v>l:VBox<cr>")
		map("n", "H", "<C-v>h:VBox<cr>")
		-- draw a box by pressing "f" with visual selection
		map("v", "f", ":VBox<cr>")
	end
end
