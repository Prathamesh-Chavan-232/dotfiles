local temp = {

	-- Plugins
	-- Git plugins
	{ "tpope/vim-rhubarb" },

	-- Editor Feature plugins
	-- Navigation plugins
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Appearance
	{ "norcalli/nvim-colorizer.lua" }, -- highlight colors
	{
		"akinsho/bufferline.nvim", -- Display open buffers
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- Syntax highlighting plugins
	{ "nvim-treesitter/playground" }, -- Playground (For Syntax Highlight weights - useful for writing plugins)
}
