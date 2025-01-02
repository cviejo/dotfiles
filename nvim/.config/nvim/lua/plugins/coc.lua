-- LuaFormatter off
vim.g.coc_global_extensions = {
	'coc-diagnostic',
	'coc-eslint',
	-- 'coc-explorer',
	'coc-git',
	'coc-go',
	'coc-json',
	'coc-lua',
	'coc-prettier',
	'coc-rls',
	'coc-snippets',
	'coc-svelte',
	'coc-tsserver',
	'coc-yaml',
	'coc-html',
	'coc-pyright',
	'coc-zls',
	'https://github.com/nathanchapman/vscode-javascript-snippets'
}
-- LuaFormatter on

vim.g.coc_snippet_next = '<tab>'

return { 'neoclide/coc.nvim', branch = 'release' }
