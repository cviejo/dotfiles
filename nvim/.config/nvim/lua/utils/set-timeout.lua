return function(fn, timeout)
	local timer = vim.loop.new_timer()

	timer:start(timeout, 0, vim.schedule_wrap(function()
		fn()
		timer:stop()
		timer:close()
	end))
end
