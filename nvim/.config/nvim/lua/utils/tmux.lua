local buffer = require('utils.buffer')

return {
  horizontalSplit = function()
    vim.fn.system('tmux split-window -c ' .. buffer.getDirectory())
  end,
  verticalSplit = function()
    vim.fn.system('tmux split-window -h -c ' .. buffer.getDirectory())
  end
}
