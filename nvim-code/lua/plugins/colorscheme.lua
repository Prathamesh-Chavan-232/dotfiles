return {
	{
		"ribru17/bamboo.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			local bamboo = require("bamboo")
			bamboo.setup({
				transparent = true,
			})

			-- Highlights
			vim.cmd.hi("clear", "NormalFloat")
			vim.cmd.hi("link", "NormalFloat", "Normal")
		end,
	},
	{
		"deparr/tairiki.nvim",
lazy = true,
		priority = 1000, -- only necessary if you use tairiki as default theme
		config = function()
			require("tairiki").setup({
				-- optional configuration here
				transparent = true,
			})
		end,
	},
	{
		"daschw/leaf.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			local leaf = require("leaf")
			leaf.setup({
				contrast = "medium",
				transparent = true,
			})

			-- Highlights
			vim.cmd.hi("clear", "NormalFloat")
			vim.cmd.hi("link", "NormalFloat", "Normal")
		end,
	},
	{
		"gmr458/black_white.nvim",
		lazy = true,
		priority = 1000,
		build = ":BlackWhiteCompile",
		config = function()
			require("black_white").setup({
				transparent_background = false,
				cursorline = false,
				treesitter_context_underline = true,
			})
		end,
	},
	{
		"gmr458/cold.nvim",
		lazy = true,
		priority = 1000,
		build = ":ColdCompile",
		config = function()
			require("cold").setup({
				transparent_background = false,
			})
		end,
	},
	{
		"gmr458/vscode_modern_theme.nvim",
		branch = "dev",
		lazy = false,
		priority = 1000,
		config = function()
			local vscode_modern = require("vscode_modern")

			vscode_modern.setup({
				cursorline = true,
				transparent_background = false,
				nvim_tree_darker = true,
				italic_keyword = false,
				custom_dark_background = "#111111",
				custom_statusline_dark_background = "#080808",
			})

			vim.cmd.colorscheme("vscode_modern")
		end,
	},
}
