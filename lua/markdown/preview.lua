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
	vim.api.nvim_buf_set_option(win.buf, "filetype", "markdown")
end

function M.open()
	if M.load_current_buffer() then
		win.create_floating_window()
		M.render_slide()
		vim.keymap.set("n", "n", function()
			M.next_slide()
		end, { buffer = win.buf })
		vim.keymap.set("n", "p", function()
			M.prev_slide()
		end, { buffer = win.buf })
		vim.keymap.set("n", "f", function()
			win.fullscreen()
		end, { buffer = win.buf })
	end
end

function M.next_slide()
	M.current_slide = math.min(M.current_slide + 1, #M.slides)
	M.render_slide()
end

function M.prev_slide()
	M.current_slide = math.max(M.current_slide - 1, 1)
	M.render_slide()
end

return M
