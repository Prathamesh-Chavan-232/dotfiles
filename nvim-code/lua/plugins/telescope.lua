return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false,
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		"danielfalk/smart-open.nvim",
		"kkharji/sqlite.lua",
		"nvim-telescope/telescope-fzy-native.nvim",
		"willthbill/opener.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")

		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>fo", function()
			telescope.extensions.smart_open.smart_open()
		end, { noremap = true, silent = true })
		telescope.setup({
			file_ignore_patterns = { "%.git/." },
			defaults = {
				preview = {
					treesitter = false,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
			borderchars = {
				prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				results = { " ", " ", " ", " ", " ", " ", " ", " " },
			},
		})
		telescope.load_extension("ui-select")
		telescope.load_extension("refactoring")
		-- telescope.load_extension("notify")
		telescope.load_extension("smart_open")
		telescope.load_extension("opener")
	end,
}
