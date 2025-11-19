return {
	"saghen/blink.cmp",
	opts = {
		completion = {
			menu = {
				winblend = vim.o.pumblend,
			},
		},
		signature = {
			window = {
				winblend = vim.o.pumblend,
			},
		},

		keymap = {
			preset = "default",
			-- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			-- ["<C-e>"] = { "hide" }, -- Hide completion
			["<C-y>"] = { "select_and_accept" }, -- Accept completion

			-- Tab behavior - navigate without auto-selecting
			["<C-n>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_next()
					else
						return cmp.show()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<C-p>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_prev()
					end
				end,
				"snippet_backward",
				"fallback",
			},

			["<CR>"] = { "accept", "fallback" },
		},
	},
}
