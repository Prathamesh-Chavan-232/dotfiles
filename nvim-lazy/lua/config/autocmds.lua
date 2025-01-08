-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

-- turn on spell check for markdown and text file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- keymap for .cpp file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.cpp", "*.cc" },
	callback = function()
		vim.keymap.set("n", "<Leader>e", ":terminal ./a.out<CR>", { silent = true })
		-- vim.keymap.set("n", "<Leader>e", ":!./sfml-app<CR>",
		--    { silent = true })
	end,
})

-- tab format for .lua file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.lua" },
	callback = function()
		vim.opt.shiftwidth = 3
		vim.opt.tabstop = 3
		vim.opt.softtabstop = 3
		-- vim.opt_local.colorcolumn = {70, 80}
	end,
})

-- keymap for .cpp file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.go" },
	callback = function()
		vim.keymap.set("n", "<Leader>e", ":terminal go run %<CR>", { silent = true })
	end,
})
