local M = {}

M.buf = nil
M.win = nil

function M.open()
    if M.buffer and vim.api.nvim_buf_is_valid(M.buf) then
        vim.notify("preview already open", vim.log.levels.INFO)
        return
    end
    M.buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(M.buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(M.buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(M.buf, "filetype", "markdown")

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
    vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, { "This is your preview" })
end

function M.close()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_win_close(M.win, true)
    end
    M.buf = nil
    M.win = nil
end

function M.toggle()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        M.close()
    else
        M.open()
    end
end

return M
