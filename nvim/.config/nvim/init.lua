require('keymap')
require('options')
require('plugins')
require('commands')

local F = require('utils.functional')

local env = vim.fn.getenv('color')
print("env", vim.inspect(env));

local colors = require('catppuccin.api.colors').get_colors()

-- vim.pretty_print(colors)
