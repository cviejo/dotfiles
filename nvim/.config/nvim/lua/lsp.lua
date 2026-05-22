local function has(cmd)
	return vim.fn.executable(cmd) == 1
end

local function enable(name, config)
	if not has(config.cmd[1]) then
		return
	end

	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

vim.diagnostic.config({
	virtual_text = true,
	float = { border = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '✖',
			[vim.diagnostic.severity.WARN] = '⚠',
			[vim.diagnostic.severity.INFO] = '⚐',
			[vim.diagnostic.severity.HINT] = 'ẍ'
		}
	}
})

enable('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'draw', 'jit', 'mpd', 'of', 'setup', 'swig_type', 'vim' }
			}
		}
	}
})

enable('ccls', {
	cmd = { 'ccls' },
	filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
	root_markers = { 'compile_commands.json', '.ccls', '.git' },
	init_options = {
		cache = { directory = '/tmp/ccls' }
	}
})

enable('ts_ls', {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
	init_options = {
		implicitProjectConfiguration = {
			checkJs = true
		},
		preferences = {
			disableSuggestions = true
		}
	},
	settings = {
		implicitProjectConfiguration = {
			checkJs = true
		}
	}
})

-- enable('eslint', {
-- 	cmd = { 'vscode-eslint-language-server', '--stdio' },
-- 	filetypes = { 'html', 'javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact', 'vue' },
-- 	root_markers = {
-- 		'eslint.config.js',
-- 		'eslint.config.mjs',
-- 		'eslint.config.cjs',
-- 		'.eslintrc',
-- 		'.eslintrc.js',
-- 		'.eslintrc.json',
-- 		'package.json'
-- 	},
-- 	settings = {
-- 		codeAction = {
-- 			disableRuleComment = { enable = true, location = 'separateLine' },
-- 			showDocumentation = { enable = true }
-- 		},
-- 		codeActionOnSave = { enable = false, mode = 'all' },
-- 		format = false,
-- 		nodePath = '',
-- 		packageManager = 'npm',
-- 		problems = { shortenToSingleLine = false },
-- 		quiet = false,
-- 		run = 'onType',
-- 		validate = 'on',
-- 		workingDirectory = { mode = 'auto' }
-- 	}
-- })
