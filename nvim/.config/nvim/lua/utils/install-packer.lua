-- LuaFormatter off
local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local cmd = 'git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. path
-- LuaFormatter on

local notExists = function(x)
	return vim.fn.empty(vim.fn.glob(x)) > 0
end

if notExists(path) then
	vim.fn.system(vim.fn.split(cmd))
end
