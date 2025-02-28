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
		vim.keymap.set("n", "<leader>e", ":terminal ./a.out<CR>", { silent = true })
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
		vim.keymap.set("n", "<leader>e", ":terminal go run %<CR>", { silent = true })
	end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- auto close brackets
vim.api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = cursorGrp,
})
vim.api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	-- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
	{
		pattern = { "*.txt", "*.md", "*.tex" },
		callback = function()
			vim.opt.spell = true
			vim.opt.spelllang = "en,de"
		end,
	}
)

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

vim.api.nvim_create_user_command("FormatProject", function()
	local file_patterns = "**/*.{js,jsx,ts,tsx,lua,html,css,json,md}"

	-- Get all matching files in the current directory
	local files = vim.fn.glob(file_patterns, false, true)

	-- Track current buffer to return to it
	local current_bufnr = vim.api.nvim_get_current_buf()

	-- Format each file
	for _, file_path in ipairs(files) do
		-- Skip node_modules and similar directories
		if not file_path:match("node_modules") and not file_path:match("%.git/") then
			vim.cmd("edit " .. file_path)

			-- Format using none-ls
			vim.cmd("lua vim.lsp.buf.format({ async = false })")

			-- Save the file
			vim.cmd("write")
		end
	end

	-- Return to the original buffer
	vim.cmd("buffer " .. current_bufnr)
	vim.cmd('echo "Formatted ' .. #files .. ' files"')
end, {})
