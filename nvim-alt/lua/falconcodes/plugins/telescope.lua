return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- plugin setup
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },

				planets = {
					show_pluto = true,
				},
				mappings = {
					i = {
						["<C-k>"] = "move_selection_previous", -- move to prev result
						["<C-j>"] = "move_selection_next", -- move to next result
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					hidden = true,
				},
				live_grep = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
				},
			},
		})

		-- telescope extensions
		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap
		local opts = {}
		keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
		keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
		-- files
		keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
		keymap.set("n", "<C-p>", ":Telescope find_files<CR>", opts)
		keymap.set("n", "<leader>fo", ":Telescope find_files<CR>", opts)
		-- buffers
		keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
		-- search
		keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", opts)
		keymap.set("n", "<leader>fcw", ":Telescope grep_string<CR>", opts)
		-- Treesitter
		keymap.set("n", "<leader>fv", ":Telescope treesitter<CR>", opts)
		-- git
		keymap.set("n", "<leader>fgf", ":Telescope git_files<CR>", opts)
		keymap.set("n", "<leader>fgc", ":Telescope git_commits<CR>", opts)
		keymap.set("n", "<leader>fgb", ":Telescope git_branches<CR>", opts)
		keymap.set("n", "<leader>fgs", ":Telescope git_stash<CR>", opts)
		-- search themes
		-- keymap.set("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)
	end,
}
