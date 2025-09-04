local preview = require("markdown.preview")

local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("Markdown", preview.open, {})
	vim.keymap.set("n", "<leader>m", "<cmd>Markdown<CR>", { noremap = true, silent = true })
end

return M
