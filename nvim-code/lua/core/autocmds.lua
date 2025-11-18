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
		vim.keymap.set("n", "<leader>rf", ":terminal ./a.out<CR>", { silent = true })
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
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("jump_to_the_last_known_cursor_position", { clear = true }),
	pattern = { "*" },
	desc = "When editing a file, always jump to the last known cursor position",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line >= 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("restore_cursor_shape_on_exit", { clear = true }),
	pattern = { "*" },
	desc = "Restores vertical shape cursor for Alacritty on exit",
	callback = function()
		vim.opt.guicursor = "a:ver1"
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("clean_term_mode", { clear = true }),
	pattern = { "*" },
	desc = "",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("json_conceal_level_0", { clear = true }),
	desc = "Disable conceallevel and spell for JSON and JSONC",
	pattern = { "json", "jsonc" },
	callback = function()
		vim.opt_local.spell = false
		vim.opt_local.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	desc = "Close with <q>",
	pattern = {
		"help",
		"man",
		"qf",
		"query",
		"scratch",
		"spectre_panel",
	},
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual" })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_conflicts", { clear = true }),
	desc = "Prevent tsserver and volar conflict",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local active_clients = vim.lsp.get_clients()
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client ~= nil and client.name == "volar" then
			for _, c in ipairs(active_clients) do
				if c.name == "tsserver" then
					c.stop()
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("avoid_comment_new_line", { clear = true }),
	desc = "Avoid comment on new line",
	command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("consistent_size_buffers", { clear = true }),
	desc = "Keep consistent size for buffers",
	command = "tabdo wincmd =",
})

-- vim.api.nvim_create_autocmd('FileType', {
--     group = vim.api.nvim_create_augroup(
--         'wrap_spell_for_writing',
--         { clear = true }
--     ),
--     pattern = { 'gitcommit', 'markdown' },
--     desc = 'Enable wrap and spell on Git Commits and Markdown',
--     callback = function()
--         vim.opt_local.wrap = true
--     end,
-- })

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = vim.api.nvim_create_augroup("cmdheight_1_on_cmdlineenter", { clear = true }),
	desc = "Don't hide the status line when typing a command",
	command = ":set cmdheight=1",
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = vim.api.nvim_create_augroup("cmdheight_0_on_cmdlineleave", { clear = true }),
	desc = "Hide cmdline when not typing a command",
	command = ":set cmdheight=0",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("hide_message_after_write", { clear = true }),
	desc = "Get rid of message after writing a file",
	pattern = { "*" },
	command = "redrawstatus",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("disable_indentscope_filetypes", { clear = true }),
	desc = "Disable mini.indentscope in specific filetypes",
	pattern = {
		"lspinfo",
		"lazy",
		"checkhealth",
		"help",
		"man",
		"gitcommit",
		"NvimTree",
		"fzf",
		"",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
