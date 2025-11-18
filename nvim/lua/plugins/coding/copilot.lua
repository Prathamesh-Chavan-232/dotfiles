return {
	"zbirenbaum/copilot.lua",
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<C-CR>",
				accept_word = "<C-S-CR>",
				accept_line = "<M-S-CR>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
