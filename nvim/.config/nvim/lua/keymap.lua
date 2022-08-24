local F = require('utils.functional')
local toggleZoom = require('utils.toggle-zoom')
local buffer = require('utils.buffer')
local runLines = require('utils.run-lines')
local utils = require('utils.nvim')

local map = vim.keymap.set

local cmd = F.thunkify(function(x)
	return vim.cmd(x)
end)

local mapRunLines = F.thunkify(function(from, to, binary)
	return runLines(from, to, binary)
end)

local VSCodeCall = F.thunkify(function(arg)
	return vim.fn.VSCodeCall(arg)
end)

local createTextObject = function(from, to)
	map('n', 'd' .. from, 'd' .. to)
	map('n', 'c' .. from, 'c' .. to)
	map('n', 'v' .. from, 'v' .. to)
	map('n', 'y' .. from, 'y' .. to)
end

map('v', 'gi', function()
	local char = utils.getCurrentChar()
	utils.feedkeys('<esc>')
	utils.feedkeys('vi' .. char) -- TODO: limit to ({['"``"']})
end)

map('', ';', ':')
map('n', ':', '@:')
map('n', '<space>', 'o<Esc>')
map('n', 'D', 'J')
map('n', 'ZZ', cmd('qa!'))
map('n', 'vv', 'V')
map('i', '>>', '=>')
map('i', 'j[', '${}<Left>')
map('i', 'jj', '<Esc>')
map('v', '<', '<gv')
map('v', '>', '>gv')
map('t', 'jj', '<C-\\><C-n>')

-- plugins ----------------------------------
map('x', 's', '<Plug>VSurround')
map('n', 's', cmd('HopWord'))
map('n', 'S', cmd('BufferPick'))

-- coc --------------------------------------
map('i', '<tab>', 'coc#pum#visible() ? coc#pum#next(1) : "<tab>"', {expr = true})
map('i', '<s-tab>', 'coc#pum#visible() ? coc#pum#prev(1) : "<s-tab>"', {expr = true})
map('i', '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "<cr>"', {expr = true})
map('n', 'gd', '<Plug>(coc-definition)')
map('n', 'gn', '<plug>(coc-diagnostic-next)')
map('n', 'gh', cmd('call CocAction("definitionHover")'))
map('n', 'gp', '<plug>(coc-diagnostic-prev)')
map('n', 'gr', '<Plug>(coc-references)')
map('n', 'gt', '<Plug>(coc-type-definition)')

-- vimium style bindings --------------------
map('n', 'J', cmd('BufferPrevious'))
map('n', 'K', cmd('BufferNext'))
map('n', '<c-d>', '5j')
map('n', '<c-u>', '5k')
map('n', 'co', buffer.closeOther)

-- q bindings -------------------------------
map('v', 'q;', 'q:')
map('n', 'q;', 'q:')
map('n', 'qa', '<plug>(coc-codeaction-line)')
map('n', 'qc', cmd('CocCommand'))
map('n', 'qb', cmd('Buffers'))
map('n', 'ql', cmd('Lines'))
map('n', 'qp', cmd('Files'))
map('n', 'qr', cmd('History'))
map('n', 'qh', cmd('History:'))

-- window -----------------------------------
map('n', '<C-w>/', cmd('vsp'))
map('n', '<C-w>-', cmd('sp'))
map('n', '<C-w>z', toggleZoom)

-- make all marks global ------------------------
for x in ('QWERTYUIOPASDFGHJKLZXCVBNM'):gmatch(".") do
	map('n', 'm' .. x:lower(), 'm' .. x)
	map('n', '`' .. x:lower(), '`' .. x)
end

-- make inner the default behaviour ---------
for x in ([[qwbB(){}[]"'/]]):gmatch(".") do
	createTextObject(x, 'i' .. x)
end

-- (r)ound (c)urly (s)quare
for from, to in pairs({s = '[', r = '(', c = '{'}) do
	createTextObject('i' .. from, 'i' .. to)
	createTextObject('a' .. from, 'a' .. to)
end

-- shortcuts for frequent sequences ---------
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
	createTextObject(from, to)
end

map('n', 'vp', 'vip')
map('n', 'vrb', 'v])h')

-- leader ----------------------------------------
vim.g.mapleader = "'"
map('n', '<leader>;', '@:')
map('v', '<leader>;', '@:')
map('n', '<leader>a', 'ggVG')
map('n', '<leader>c', '<Plug>(comment_toggle_current_linewise)')
map('v', '<leader>c', [[
   mode() ==# "V" ? "<Plug>(comment_toggle_linewise_visual)" : "<Plug>(comment_toggle_blockwise_visual)"
]], {expr = true})
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

if vim.g.vscode then
	map('n', 'J', VSCodeCall('workbench.action.previousEditor'))
	map('n', 'K', VSCodeCall('workbench.action.nextEditor'))
	map('n', 'qp', VSCodeCall('workbench.action.quickOpen'))
	map('n', 'qwo', VSCodeCall('workbench.action.joinAllGroups'))
	map('n', 'qw/', VSCodeCall('workbench.action.splitEditorRight'))
	map('n', 'qw-', VSCodeCall('workbench.action.splitEditorDown'))
	map('n', '<leader>e', VSCodeCall('workbench.action.toggleSidebarVisibility'))
	map('n', '<leader>d', VSCodeCall('workbench.action.closeActiveEditor'))
	map('n', '<leader>w', VSCodeCall('workbench.action.files.save'))
	map('n', 'za', VSCodeCall('editor.toggleFold'))
	map('n', 'zR', VSCodeCall('editor.unfoldAll'))
	map('n', 'zM', VSCodeCall('editor.foldAll'))
	map('n', 'zo', VSCodeCall('editor.unfold'))
	map('n', 'zO', VSCodeCall('editor.unfoldRecursively'))
	map('n', 'zc', VSCodeCall('editor.fold'))
	map('n', 'zC', VSCodeCall('editor.foldRecursively'))
end
