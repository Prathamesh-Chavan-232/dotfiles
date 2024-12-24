require("config.core")

vim.api.nvim_create_autocmd("VimLeave", {
	command = "set guicursor=a:block",
})
