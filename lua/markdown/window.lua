local M = {}

M.buf = nil
M.win = nil

function M.create_floating_window()
    if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
        vim.notify("preview already open", vim.log.levels.INFO)
    else
        M.buf = vim.api.nvim_create_buf(false, true)
    end

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

    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(M.win, true)
    end, { buffer = M.buf })
end

function M.fullscreen()
    if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
        local cmd_height = vim.o.cmdheight or 1
        local height = vim.o.lines - cmd_height - 2
        local width = vim.o.columns
        local opts = {
            relative = "editor",
            width = width,
            height = height,
            row = 0,
            col = 0,
            style = "minimal",
            border = "rounded",
        }
        vim.api.nvim_win_set_config(M.win, opts)
    end
end

return M
