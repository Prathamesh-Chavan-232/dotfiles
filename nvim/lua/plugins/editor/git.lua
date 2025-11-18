return {
	"dinhhuy258/git.nvim",
	event = "BufReadPre",
	opts = {
		keymaps = {
			-- Open blame window
			blame = "<leader>gb",
			-- Open file/folder in git repository
			browse = "<leader>go",
		},
	},
}
