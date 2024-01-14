local config = function()
	local toggleterm = require("toggleterm")

	toggleterm.setup({
		size = 13,
		open_mapping = [[<C-\>]],
		shade_filetypes = {},
		shade_terminal = true,
		shading_factor = 2,
		start_in_insert = true,
		persist_size = true,
		direction = "horizontal",
		autochdir = true,
	})
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	priority = 999,
	lazy = false,
	config = config,
}
