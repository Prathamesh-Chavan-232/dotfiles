local config = function()
	local toggleterm = require("toggleterm")

	toggleterm.setup({
		size = 13,
		open_mapping = [[<C-\>]],
		shade_filetypes = {},
		shade_terminal = true,
		shading_factor = 2,
		persist_size = true,
		direction = "float",
		autochdir = true,
		hidden = true,
	})
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = config,
}
