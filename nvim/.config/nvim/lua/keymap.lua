local F = require('utils.functional')
local toggleZoom = require('utils.toggle-zoom')
local buffer = require('utils.buffer')
local runLines = require('utils.run-lines')
local utils = require('utils.nvim')

local map = vim.keymap.set

local cmd = F.thunkify(vim.cmd)

local feedkeys = F.thunkify(utils.feedkeys)

local mapRunLines = F.thunkify(runLines)

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
--
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

-- g bindings (mostly coc) ------------------
map('i', '<tab>', 'coc#pum#visible() ? coc#pum#next(1) : "<tab>"',
    {expr = true, replace_keycodes = false})
map('i', '<s-tab>', 'coc#pum#visible() ? coc#pum#prev(1) : "<s-tab>"',
    {expr = true, replace_keycodes = false})
map('i', '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "<cr>"',
    {expr = true, replace_keycodes = false})
map('n', 'gd', '<Plug>(coc-definition)')
map('n', 'gn', '<plug>(coc-diagnostic-next)')
map('n', 'gh', cmd('call CocAction("definitionHover")'))
map('n', 'gp', '<plug>(coc-diagnostic-prev)')
map('n', 'gr', '<Plug>(coc-references)')
map('n', 'gt', '<Plug>(coc-type-definition)')
map('n', 'gz', ':TZAtaraxis<cr>')
map('x', 'gz', ":'<,'>TZNarrow<cr>")

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
map('n', ',', '<c-w>', {remap = true})
map('n', '<C-w>/', cmd('vsp'))
map('n', '<C-w>-', cmd('sp'))
map('n', '<C-w>z', toggleZoom)
map('n', '<C-w>d', '<C-w>q')
-- map('n', '<C-w>zs', cmd('BufferPick'))

-- make all marks global ---------------------
for x in ('QWERTYUIOPASDFGHJKLZXCVBNM'):gmatch(".") do
	map('n', 'm' .. x:lower(), 'm' .. x)
	map('n', '`' .. x:lower(), '`' .. x)
end

-- make inner the default behaviour ---------
for x in ([[wbB(){}[]"'/]]):gmatch(".") do
	createTextObject(x, 'i' .. x)
end

-- double (q)uote
for from, to in pairs({q = '"'}) do
	createTextObject(from, 'i' .. to) -- inner is default
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

-- leader ------------------------------------
vim.g.mapleader = "'"
map('n', '<leader>;', '@:')
map('v', '<leader>;', '@:')
map('n', '<leader>a', 'ggVG')
map('n', '<leader>c', '<Plug>(comment_toggle_linewise_current)')
map('v', '<leader>c', '<Plug>(comment_toggle_linewise_visual)')
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
map('x', '<leader>n', feedkeys('*')) -- 0.8
map('n', '<leader>o', 'o<Esc>')
map('v', '<leader>p', '"_dP')
map('n', '<leader>q', '@q')
map('x', '<leader>q', ": norm @q<cr>")
map('n', '<leader>r', 'q:k<cr>') -- probably don't need this, enough with 'q for the macros
map('x', '<leader>s', '<Plug>SlimeRegionSend')
map('n', '<leader>s', '<Plug>SlimeParagraphSend')
map('x', '<leader>t', ":'<,'>Translate DE<cr>")
map('n', '<leader>w', cmd('w'))
map('n', '<leader>z', mapRunLines("'{", "'}", "zsh"))
map('x', '<leader>z', mapRunLines("'<", "'>", "zsh"))

-- folding ----------------------------------
map('n', 'zl', 'zr') -- opposite of fold (zm)ore is fold (zl)ess
map('n', 'zL', 'zR') -- also, zr is not very ergonomical

if vim.g.vscode then
	map('n', 'J', VSCodeCall('workbench.action.previousEditor'))
	map('n', 'K', VSCodeCall('workbench.action.nextEditor'))
	map('n', 'qp', VSCodeCall('workbench.action.quickOpen'))
	map('n', ',o', VSCodeCall('workbench.action.joinAllGroups'))
	map('n', ',/', VSCodeCall('workbench.action.splitEditorRight'))
	map('n', ',-', VSCodeCall('workbench.action.splitEditorDown'))
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
