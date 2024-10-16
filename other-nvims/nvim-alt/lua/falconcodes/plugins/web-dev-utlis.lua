return {
	-- emmet
	{
		"mattn/emmet-vim",
	},
	-- lorem ipsum
	{
		"derektata/lorem.nvim",
		config = function()
			local lorem = require("lorem")
			lorem.setup({
				sentenceLength = "mixedShort",
				comma = 1,
			})
		end,
	},
	-- auto close html, jsx tags
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- highlight hex colors
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			vim.o.termguicolors = true
			local colorizer = require("colorizer")

			colorizer.setup()
		end,
	},
}
