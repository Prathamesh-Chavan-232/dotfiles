return {
	"famiu/bufdelete.nvim",
	init = function()
		vim.keymap.set("n", "<leader>bd", function()
			require("bufdelete").bufdelete(0, false)
		end, { silent = true, desc = "Quit Buffer" })
		vim.keymap.set("n", "<C-w>", function()
			require("bufdelete").bufdelete(0, false)
		end, { silent = true, desc = "Quit Buffer" })
	end,
}
