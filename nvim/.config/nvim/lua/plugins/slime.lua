vim.g.slime_default_config = { target_pane = '{next}', socket_name = 'default' }
vim.g.slime_dont_ask_default = 1
vim.g.slime_target = 'tmux'
vim.g.slime_paste_file = os.getenv('HOME') .. '/.local/share/nvim/.slime_paste'

-- replace all const and lets with vars so that we can resend the same chunk
_G.slimeEscapeJavascript = function(x)
	return x:gsub('const[%s]+', 'var '):gsub('let[%s]+', 'var '):gsub('[%s]+%.', '.')
end

-- for chuck, remove newlines and comments
_G.slimeEscapeChuck = function(x)
	return x:gsub('[%s]*//[^\n]*', ''):gsub('[\n\r]+[%s]*', '') .. '\n'
end

-- for markdown prompts, remove leading '#' and empty lines
_G.slimeEscapeMarkdownPrompt = function(x)
	return x:gsub('[%s]*//[^\n]*', ''):gsub('[\n\r]+[%s]*', '') .. '\n'
end

vim.cmd([[
function! SlimeOverride_EscapeText_javascript(text)
	return v:lua.slimeEscapeJavascript(a:text)
endfunction

function! SlimeOverride_EscapeText_chuck(text)
	return v:lua.slimeEscapeChuck(a:text)
endfunction

function! SlimeOverride_EscapeText_markdown(text)
	return v:lua.slimeEscapeMarkdownPrompt(a:text)
endfunction
]])

return { 'jpalardy/vim-slime' }
