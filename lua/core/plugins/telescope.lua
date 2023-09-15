local builtin = require('telescope.builtin')


-- fuzy find files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
-- fuzy find git files
-- vscode remap
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- open buffers
-- vim.keymap.set('n', '<leader><space>', builtin.buffers, {})

-- fzf help
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- search grep string
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- search themes
vim.keymap.set('n', '<leader>ft', builtin.colorscheme, {})
local actions = require "telescope.actions"

require("telescope").setup {
	defaults = {
		previewer = false,
		shorten_path = true,
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				["<c-n>"] = actions.cycle_history_next,
				["<c-p>"] = actions.cycle_history_prev,

				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,

				["<c-c>"] = actions.close,

				["<down>"] = actions.move_selection_next,
				["<up>"] = actions.move_selection_previous,

				["<cr>"] = actions.select_default,
				["<c-x>"] = actions.select_horizontal,
				["<c-v>"] = actions.select_vertical,
				["<c-t>"] = actions.select_tab,

				["<c-u>"] = actions.preview_scrolling_up,
				["<c-d>"] = actions.preview_scrolling_down,

				["<pageup>"] = actions.results_scrolling_up,
				["<pagedown>"] = actions.results_scrolling_down,

				["<tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<m-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<c-l>"] = actions.complete_tag,
			},

			n = {
				["<esc>"] = actions.close,
				["<cr>"] = actions.select_default,
				["<c-x>"] = actions.select_horizontal,
				["<c-v>"] = actions.select_vertical,
				["<c-t>"] = actions.select_tab,

				["<tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<s-tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<m-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["h"] = actions.move_to_top,
				["m"] = actions.move_to_middle,
				["l"] = actions.move_to_bottom,

				["<down>"] = actions.move_selection_next,
				["<up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["g"] = actions.move_to_bottom,

				["<c-u>"] = actions.preview_scrolling_up,
				["<c-d>"] = actions.preview_scrolling_down,

				["<pageup>"] = actions.results_scrolling_up,
				["<pagedown>"] = actions.results_scrolling_down,

			},
		},
	},
	pickers = {

		-- default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- now the picker_config_key will be applied every time you call this
		-- builtin picker
		planets = {
			show_pluto = true,
		},
	},
	extensions = {
		-- your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
}
