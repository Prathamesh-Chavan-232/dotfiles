return {
	{
		"ribru17/bamboo.nvim",
		lazy = false,
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
		lazy = false,
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
		lazy = false,
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
}
