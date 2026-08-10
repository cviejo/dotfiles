-- LuaFormatter off
vim.g.coc_global_extensions = {
	'coc-diagnostic@0.24.1',
	'coc-eslint@3.0.15',
	'coc-explorer@0.27.3',
	'coc-git@2.7.7',
	'coc-go@1.3.35',
	'coc-json@1.9.3',
	'coc-lua@2.0.6',
	'coc-prettier@11.0.1',
	-- 'coc-oxc',
	'coc-rls@1.1.6',
	'coc-snippets@3.4.7',
	'coc-svelte@0.5.0',
	'coc-tsserver@2.3.1',
	'coc-yaml@1.9.1',
	'coc-html@1.8.0',
	'coc-pyright@1.1.408',
	'coc-zls@0.0.6',
}
-- LuaFormatter on

vim.g.coc_snippet_next = '<tab>'

return { 'neoclide/coc.nvim', branch = 'release' }
