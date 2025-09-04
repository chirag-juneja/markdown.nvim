local M = {}

local preview = require("markdown.preview")

M.setup = function(opts)
    opts = opts or {}
    local keymap = opts.keymap or "<leader>m"
    vim.api.nvim_create_user_command("MarkdownOpen", preview.open, {})
    vim.api.nvim_create_user_command("MarkdownClose", preview.close, {})
    vim.api.nvim_create_user_command("MarkdownToggle", preview.toggle, {})

    vim.keymap.set("n", keymap, "<cmd>MarkdownToggle<CR>", { noremap = true, silent = true })
end

return M
