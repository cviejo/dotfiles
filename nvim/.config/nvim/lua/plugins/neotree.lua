local F = require('utils.functional')

local copy_path = function(state)
	vim.fn.setreg('+', state.tree:get_node().path)
	vim.notify('Copied path to clipboard')
end

local copy_path_visual = function(_, selection)
	local paths = F.map(function(node)
		return node.path
	end, selection)
	vim.fn.setreg('+', table.concat(paths, '\n'))
	vim.notify('Copied ' .. #selection .. ' paths to clipboard')
end

local copy_name = function(state)
	vim.fn.setreg('+', state.tree:get_node().name)
	vim.notify('Copied name to clipboard')
end

local copy_name_visual = function(_, selection)
	local names = F.map(function(node)
		return node.name
	end, selection)
	vim.fn.setreg('+', table.concat(names, '\n'))
	vim.notify('Copied ' .. #selection .. ' names to clipboard')
end

return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v3.x',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
	opts = {
		commands = {
			copy_path = copy_path,
			copy_path_visual = copy_path_visual,
			copy_name = copy_name,
			copy_name_visual = copy_name_visual
		},
		window = {
			mappings = {
				['y'] = 'noop',
				['yy'] = 'copy_to_clipboard',
				['yp'] = 'copy_path',
				['yn'] = 'copy_name',
				['l'] = 'open',
				['h'] = 'close_node'
			}
		},
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false }
		},
		default_component_configs = {
			git_status = {
				symbols = {
					-- added = '',
					-- deleted = '',
					-- modified = '',
					added = '',
					deleted = '',
					modified = '',
					renamed = '',
					untracked = '',
					ignored = '',
					unstaged = '',
					staged = '',
					conflict = ''
				}
			}
		}
	}
}
