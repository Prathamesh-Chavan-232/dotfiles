return {
	"kazhala/close-buffers.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>th",
			function()
				require("close_buffers").delete({ type = "hidden" })
			end,
			"Close Hidden Buffers",
		},
		{
			"<leader>tu",
			function()
				require("close_buffers").delete({ type = "nameless" })
			end,
			"Close Nameless Buffers",
		},
	},
}
