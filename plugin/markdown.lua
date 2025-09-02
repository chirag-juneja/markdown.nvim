local markdonw = require("markdown")

vim.api.nvim_create_user_command("Markdown", function()
	markdonw.hello()
end, {})
