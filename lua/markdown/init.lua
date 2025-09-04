local preview = require("markdown.preview")

local M = {}

M.setup = function(opts)
	opts = opts or {}
	local keymap = opts.keymap or "<leader>m"
	local nextmap = opts.nextmap or "<leader>]"
	local prevmap = opts.prevmap or "<leader>["

	vim.api.nvim_create_user_command("MarkdownToggle", preview.toggle, {})
	vim.api.nvim_create_user_command("MarkdownNext", preview.next_slide, {})
	vim.api.nvim_create_user_command("MarkdownPrev", preview.prev_slide, {})

	vim.keymap.set("n", keymap, "<cmd>MarkdownToggle<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", nextmap, "<cmd>MarkdownNext<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", prevmap, "<cmd>MarkdownPrev<CR>", { noremap = true, silent = true })
end

return M
