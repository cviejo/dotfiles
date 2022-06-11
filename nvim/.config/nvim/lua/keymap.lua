local F = require('utils.functional')
local toggleZoom = require('utils.toggle-zoom')
local buffer = require('utils.buffer')
local runLines = require('utils.run-lines')
local log = require('utils.log')

local map = vim.keymap.set

local cmd = F.thunkify(function(x)
	return vim.cmd(x)
end)

local mapRunLines = F.thunkify(function(from, to, binary)
	return runLines(from, to, binary)
end)

local handleInsertTab = function()
	return vim.fn.pumvisible() == 1 and '<C-N>' or '<Tab>'
end

-- plugins ----------------------------------
map('x', 's', '<Plug>VSurround')
map('n', 'cm', cmd('CocCommand'))
map('n', 's', cmd('HopWord'))
map('i', '<Tab>', handleInsertTab, {expr = true})

map('', ';', ':')
map('n', '<space>', 'o<Esc>')
-- map('n', 'S', 'J')
map('n', 'S', cmd('BufferPick'))
map('n', 'ZZ', cmd('qa!'))
map('n', 'vv', 'V')
map('i', '>>', '=>')
map('i', 'j[', '${}<Left>')
map('i', 'jj', '<Esc>')
map('v', '<', '<gv')
map('v', '>', '>gv')
map('t', 'jj', '<C-\\><C-n>')

-- vimium bindings -----------------------------
map('n', 'J', cmd('BufferPrevious'))
map('n', 'K', cmd('BufferNext'))
map('n', '<c-d>', '5j')
map('n', '<c-u>', '5k')
map('n', 'co', buffer.closeOther)

-- g bindings -----------------------------------
map('n', 'gl', 'L')
map('n', 'gm', 'M')
map('n', 'gh', 'H')
map('n', 'gt', '<Plug>(coc-type-definition)')
map('n', 'gd', '<Plug>(coc-definition)')
map('n', 'gr', '<Plug>(coc-references)')

-- q bindings -----------------------------------
map('v', 'q;', 'q:')
map('n', 'q;', 'q:')
map('n', 'qb', cmd('Buffers'))
map('n', 'ql', cmd('Lines'))
map('n', 'qp', cmd('Files'))
map('n', 'qr', cmd('History'))
map('n', 'qh', cmd('History:'))

-- window ---------------------------------------
map('n', 'qww', '<C-w>w')
map('n', 'qwo', '<C-w>o')
map('n', 'qw/', cmd('vsp'))
map('n', 'qw-', cmd('sp'))
map('n', 'qwz', toggleZoom) --

-- make all marks global ------------------------
for x in ('QWERTYUIOPASDFGHJKLZXCVBNM'):gmatch(".") do
	map('n', 'm' .. x:lower(), 'm' .. x)
	map('n', '`' .. x:lower(), '`' .. x)
end

-- make inner the default behaviour -------------
for x in ('wB(){}[]"\'/'):gmatch(".") do
	map('n', 'd' .. x, 'di' .. x)
	map('n', 'c' .. x, 'ci' .. x)
	map('n', 'v' .. x, 'vi' .. x)
	map('n', 'y' .. x, 'yi' .. x)
end

-- shortcuts for frequent sequences ---------------
local abbreviations = {
	l = '$',
	p = 'ap',
	rb = '])',
	rB = ']]',
	[','] = 't,',
	['.'] = 't.',
	[';'] = 't;',
	[':'] = 't:',
	['<space>'] = 't<space>'
}
for from, to in pairs(abbreviations) do
	map('n', 'd' .. from, 'd' .. to)
	map('n', 'c' .. from, 'c' .. to)
	map('n', 'v' .. from, 'v' .. to)
	map('n', 'y' .. from, 'y' .. to)
end

map('n', 'vp', 'vip')
map('n', 'vrb', 'v])h')

-- leader ----------------------------------------
vim.g.mapleader = "'"
map('n', '<leader>;', '@:')
map('v', '<leader>;', '@:')
map('n', '<leader>a', 'ggVG')
map('n', '<leader>d', buffer.close)
map('n', '<leader>e', cmd('CocCommand explorer'))
map('n', '<leader>f', ':Rg ')
map('v', '<leader>f', [["vy:Rg <c-r>=escape(@v, '[].')<cr><cr>]])
map('n', '<leader>g', cmd('G'))
map('n', '<leader>h', cmd('noh'))
map('n', '<leader>i', [[mb"vyiw`b:Rg <c-r>=escape(@v, '[].')<cr><cr>]])
map('n', '<leader>j', mapRunLines("'{", "'}", "node"))
map('x', '<leader>j', mapRunLines("'<", "'>", "node"))
map('n', '<leader>n', '*')
map('n', '<leader>o', 'o<Esc>')
map('v', '<leader>p', '"_dP')
map('n', '<leader>q', '@q')
map('x', '<leader>q', ": norm @q<cr>")
map('n', '<leader>r', 'q:k<cr>') -- probably don't need this, enough with 'q for the macros
map('x', '<leader>s', '<Plug>SlimeRegionSend')
map('n', '<leader>s', '<Plug>SlimeParagraphSend')
map('n', '<leader>t', cmd('Twilight'))
map('n', '<leader>w', cmd('w'))
map('n', '<leader>z', mapRunLines("'{", "'}", "zsh"))
map('x', '<leader>z', mapRunLines("'<", "'>", "zsh"))
