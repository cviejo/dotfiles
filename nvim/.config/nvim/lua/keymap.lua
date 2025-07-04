local F = require('utils.functional')
local toggleZoom = require('utils.toggle-zoom')
local buffer = require('utils.buffer')
local runLines = require('utils.run-lines')
local utils = require('utils.nvim')
local tmux = require('utils.tmux')

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
map('n', '<cr>', 'viw')

-- plugins ----------------------------------
map('x', 's', '<Plug>VSurround')
map('n', 's', cmd('HopWord'))
map('n', 'S', cmd('BufferPick'))

-- g bindings (mostly coc) ------------------
map('i', '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "<cr>"',
    { expr = true, replace_keycodes = false })
map('n', 'gd', '<Plug>(coc-definition)')
map('n', 'gn', '<plug>(coc-diagnostic-next)')
map('n', 'gp', '<plug>(coc-diagnostic-prev)')
map('n', 'gr', '<Plug>(coc-references)')
map('n', 'gt', '<Plug>(coc-type-definition)')
map('n', 'gz', ':TZAtaraxis<cr>')
map('x', 'gz', ':\'<,\'>TZNarrow<cr>')

-- vimium style bindings --------------------
map('n', 'J', cmd('BufferPrevious'))
map('n', 'K', cmd('BufferNext'))

-- map('n', '[', cmd('BufferPrevious'), { nowait = true })
-- map('n', ']', cmd('BufferNext'), { nowait = true })
-- map('n', 'J', '}')
-- map('n', 'K', '{')

map('n', '<tab>', cmd('BufferNext'))
map('n', '<s-tab>', cmd('BufferPrevious'))
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
map('n', ',', '<c-w>', { remap = true })
map('n', '<C-w><tab>', '<C-w><C-w>')
map('n', '<C-w>/', cmd('vsp'))
map('n', '<C-w>-', cmd('sp'))
map('n', '<C-w>z', toggleZoom)
map('n', '<C-w>d', '<C-w>q')
map('x', ',ai', ':\'<,\'>NeoAIContext<cr>')
map('n', ',ai', ':NeoAI<cr>')

-- make all marks global --------------------
for x in ('QWERTYUIOPASDFGHJKLZXCVBNM'):gmatch('.') do
	map('n', 'm' .. x:lower(), 'm' .. x)
	map('n', '`' .. x:lower(), '`' .. x)
end

-- make inner the default behaviour ---------
-- for x in ([[wbB(){}[]"'/]]):gmatch('.') do
for x in ([[wbB(){}[]"'/]]):gmatch('.') do
	createTextObject(x, 'i' .. x)
end

-- double quote (q), curly brace (c) --------
for from, to in pairs({ q = '"', c = '}' }) do
	-- createTextObject(from, 'i' .. to) -- inner is default
	createTextObject('i' .. from, 'i' .. to)
	createTextObject('a' .. from, 'a' .. to)
	createTextObject('t' .. from, 't' .. to)
	createTextObject('f' .. from, 'f' .. to)
	createTextObject('T' .. from, 'T' .. to)
	createTextObject('F' .. from, 'F' .. to)

	for _, x in ipairs({ 'ds', 'cs' }) do
		map('n', x .. from, x .. to, { remap = true })
	end
	map('v', 's' .. from, 's' .. to, { remap = true })
end
map('n', 'cs\'q', 'cs\'"', { remap = true })
map('n', 'cs`q', 'cs`"', { remap = true })
map('n', 'csbc', 'csb{', { remap = true })
map('n', 'cs[c', 'cs[{', { remap = true })

-- map('n', ']c', ']', { remap = true })

local verbs = { 'd', 'c', 'y' }
for _, x in ipairs(verbs) do
	map('n', x .. '<CR>', '<CR>' .. x, { remap = true })
end

-- shortcuts for frequent sequences ---------
local abbreviations = {
	p = 'ap',
	rb = '])',
	rB = ']}',
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
map('n', 'vrB', 'v]}h')

-- leader -----------------------------------
vim.g.mapleader = '\''
map('n', '<leader>;', '@:')
map('v', '<leader>;', '@:')
map('n', '<leader>a', 'ggVG')
map('n', '<leader>c', '<Plug>(comment_toggle_linewise_current)')
map('v', '<leader>c', '<Plug>(comment_toggle_linewise_visual)')
map('n', '<leader>d', buffer.close)
map('n', '<leader>e', cmd('CocCommand explorer'))
-- map('n', '<leader>e', cmd('Neotree toggle'))
map('n', '<leader>f', ':Rg ')
map('v', '<leader>f', [["vy:Rg <c-r>=escape(@v, '[].')<cr><cr>]])
map('n', '<leader>g', cmd('G'))
map('n', '<leader>h', cmd('noh'))
map('n', '<leader>i', [[mb"vyiw`b:Rg <c-r>=escape(@v, '[].')<cr><cr>]])
map('n', '<leader>j', mapRunLines('\'{', '\'}', 'node'))
map('x', '<leader>j', mapRunLines('\'<', '\'>', 'node'))
map('n', '<leader>n', '*')
map('x', '<leader>n', feedkeys('*')) -- 0.8
map('n', '<leader>o', 'o<Esc>')
map('n', '<leader>p', ':call AddPrintLine(0, 0)<CR>') -- default mappings broken after updating to lazy.nvim
map('v', '<leader>p', ':call AddPrintLine(1, 0)<CR>')
map('n', '<leader>q', '@q')
map('x', '<leader>q', ': norm @q<cr>')
map('n', '<leader>r', 'q:k<cr>') -- probably don't need this, enough with 'q for the macros
map('x', '<leader>s', '<Plug>SlimeRegionSend')
map('n', '<leader>s', '<Plug>SlimeParagraphSend')
map('x', '<leader>t', ':\'<,\'>Translate DE<cr>')
map('n', '<leader>w', cmd('w'))
map('n', '<leader>z', mapRunLines('\'{', '\'}', 'zsh'))
map('x', '<leader>z', mapRunLines('\'<', '\'>', 'zsh'))
map('n', '<leader>/', tmux.verticalSplit)
map('n', '<leader>-', tmux.horizontalSplit)

-- folding ----------------------------------
map('n', 'zl', 'zr') -- opposite of fold (zm)ore is fold (zl)ess
map('n', 'zL', 'zR') -- also, zr is not very ergonomical
map('n', 'zh', 'zm') -- opposite of fold (zm)ore is fold (zl)ess
map('n', 'zH', 'zM') -- opposite of fold (zm)ore is fold (zl)ess

-- helix ----------------------------------
for from, to in pairs({ gl = '$', gh = '0', gk = 'gg', gj = 'G', ge = 'G' }) do
	createTextObject(from, to)
	map('n', from, to)
	map('x', from, to)
end

if vim.g.vscode then
	map('n', '[', VSCodeCall('workbench.action.previousEditor'))
	map('n', ']', VSCodeCall('workbench.action.nextEditor'))
	map('n', 'J', VSCodeCall('workbench.action.previousEditor'))
	map('n', 'K', VSCodeCall('workbench.action.nextEditor'))
	map('n', 'qp', VSCodeCall('workbench.action.quickOpen'))
	map('n', ',o', VSCodeCall('workbench.action.joinAllGroups'))
	map('n', ',/', VSCodeCall('workbench.action.splitEditorRight'))
	map('n', ',-', VSCodeCall('workbench.action.splitEditorDown'))
	map('n', '<leader>e', VSCodeCall('workbench.action.toggleSidebarVisibility'))
	map('n', '<leader>d', VSCodeCall('workbench.action.closeActiveEditor'))
	map('n', '<leader>w', VSCodeCall('workbench.action.files.save'))
	map('n', 'gf', VSCodeCall('editor.action.goToDeclaration'))
	map('n', 'gd', VSCodeCall('editor.action.goToDeclaration'))
	map('n', 'za', VSCodeCall('editor.toggleFold'))
	map('n', 'zR', VSCodeCall('editor.unfoldAll'))
	map('n', 'zM', VSCodeCall('editor.foldAll'))
	map('n', 'zo', VSCodeCall('editor.unfold'))
	map('n', 'zO', VSCodeCall('editor.unfoldRecursively'))
	map('n', 'zc', VSCodeCall('editor.fold'))
	map('n', 'zC', VSCodeCall('editor.foldRecursively'))
end
