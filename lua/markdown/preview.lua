local parser = require("markdown.parser")
local win = require("markdown.window")

local M = {}
M.slides = {}
M.current_slide = 1

function M.load_current_buffer()
	local name = vim.api.nvim_buf_get_name(0)
	if not name:match("%.md$") then
		vim.notify("Current buffer is not a markdown file", vim.log.levels.WARN)
		return false
	end
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	M.slides = parser.parse(lines)
	M.current_slide = 1
	return true
end

function M.render_slide()
	local lines = M.slides[M.current_slide] or { "No slides found" }
	vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)
end

function M.toggle()
	if win.win and vim.api.nvim_win_is_valid(win.win) then
		win.close()
	else
		if M.load_current_buffer() then
			win.create_buffer()
			win.open()
			M.render_slide()
		end
	end
end

function M.next_slide()
	if M.current_slide < #M.slides then
		M.current_slide = M.current_slide + 1
		M.render_slide()
	else
		vim.notify("Last slide", vim.log.levels.INFO)
	end
end

function M.prev_slide()
	if M.current_slide > 1 then
		M.current_slide = M.current_slide - 1
		M.render_slide()
	else
		vim.notify("First slide", vim.log.levels.INFO)
	end
end

return M
