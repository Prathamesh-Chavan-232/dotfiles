local config = function()
	local toggleterm = require("toggleterm")

	toggleterm.setup({
		size = 13,
		open_mapping = [[<c-\>]],
		shade_filetypes = {},
		shade_terminal = true,
		shading_factor = 2,
		start_in_insert = true,
		persist_size = true,
		direction = "float",
		autochdir = true,
	})
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,
	config = config,
}
