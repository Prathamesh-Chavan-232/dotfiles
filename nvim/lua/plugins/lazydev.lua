return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		cmd = "LazyDev",
		opts = {
			library = {},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
