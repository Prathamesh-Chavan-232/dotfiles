return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		-- changing bg and border colors
		vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
		vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
		vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
	end,
}
