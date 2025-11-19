return {
	"zbirenbaum/copilot.lua",
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<C-CR>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			markdown = true,
			help = true,
		},
		copilot_node_command = "/Users/prathameshchavan/.nvm/versions/node/v24.5.0/bin/node",
	},
}
