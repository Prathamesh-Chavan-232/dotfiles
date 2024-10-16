-- Turn off paste mode when leave insert mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = "*",
	command = "set nopaste",
})

-- Remove trailing spaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Install new parsers automatically
local ask_install = {}
function _G.ensure_treesitter_language_installed()
	local parsers = require("nvim-treesitter.parsers")
	local lang = parsers.get_buf_lang()
	if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
		vim.schedule_wrap(function()
			vim.ui.select(
				{ "yes", "no" },
				{ prompt = "Install tree-sitter parsers for " .. lang .. "?" },
				function(item)
					if item == "yes" then
						vim.cmd("TSInstall " .. lang)
					elseif item == "no" then
						ask_install[lang] = false
					end
				end
			)
		end)()
	end
end
