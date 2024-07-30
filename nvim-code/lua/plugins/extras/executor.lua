return {
	"google/executor.nvim",
	enabled = true,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	event = "VeryLazy",
	config = function()
		local executor = require("executor")
		executor.setup({ use_split = false })
		vim.keymap.set("n", "<leader>zr", executor.commands.run, { desc = "e[X]ecutor [R]un" })
		vim.keymap.set("n", "<leader>zv", executor.commands.toggle_detail, { desc = "e[X]ecutor [V]iew" })
	end,
}
