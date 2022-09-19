local F = require('utils.functional')

vim.opt.shortmess:append("I")
vim.opt.diffopt:append("vertical")

F.assign(vim.opt, {
	-- cmdwinheight = 16,
	autoread = true,
	clipboard = "unnamedplus",
	cursorline = true,
	expandtab = false,
	foldenable = false,
	foldmethod = 'indent',
	hidden = true,
	hlsearch = true,
	ignorecase = true,
	inccommand = 'nosplit',
	laststatus = 3,
	list = true,
	listchars = 'tab:│ ,trail:·',
	mouse = "a",
	number = true,
	shiftwidth = 3,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 3,
	termguicolors = true,
	updatetime = 300
})

F.assign(vim.g, {
	--
	netrw_altv = 1,
	netrw_banner = 0,
	netrw_browse_split = 4,
	netrw_winsize = 18
})

-- backup = false,
-- cmdheight = 2,
-- completeopt = {"menuone", "noselect"},
-- conceallevel = 0,
-- expandtab = true,
-- fileencoding = "utf-8",
-- numberwidth = 4,
-- pumheight = 10,
-- relativenumber = true,
-- scrolloff = 8,
-- set complete=.,w,b,u,t,i,kspell
-- set diffopt+=vertical
-- set wildignore+=**/.git/*
-- set wildignore+=**/node_modules/*
-- set wildmenu
-- showmode = false,
-- showtabline = 0,
-- sidescrolloff = 8,
-- signcolumn = "yes",
-- undofile = true,
-- wrap = false,
-- writebackup = false
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.opt.fillchars.eob = " "
-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]]
