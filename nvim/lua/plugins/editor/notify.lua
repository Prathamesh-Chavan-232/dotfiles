return {
	"rcarriga/nvim-notify",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>sn",
			function()
				require("telescope").extensions.notify.notify()
			end,
			desc = "Notifications",
		},
	},
	opts = {
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		stages = "fade_in_slide_out",
		render = "compact", -- or "minimal", "simple", "default"
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify

		require("telescope").load_extension("notify")
	end,
}
