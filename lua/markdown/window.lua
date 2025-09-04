local M = {}

M.buf = nil
M.win = nil

function M.create_buffer()
	if M.buffer and vim.api.nvim_buf_is_valid(M.buf) then
		vim.notify("preview already open", vim.log.levels.INFO)
		return
	end
	M.buf = vim.api.nvim_create_buf(false, true)
end

function M.open()
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}
	M.win = vim.api.nvim_open_win(M.buf, true, opts)
end

function M.close()
	if M.win and vim.api.nvim_win_is_valid(M.win) then
		vim.api.nvim_win_close(M.win, true)
	end
	M.win = nil
	M.buf = nil
end

return M
