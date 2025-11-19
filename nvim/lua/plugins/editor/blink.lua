return {
	"saghen/blink.cmp",
	opts = {
		completion = {
			menu = {
				winblend = vim.o.pumblend,
			},
			list = {
				selection = { preselect = false, auto_insert = false },
			},
		},
		signature = {
			window = {
				winblend = vim.o.pumblend,
			},
		},
		keymap = {
			preset = "default",
			["<C-e>"] = { "show", "hide" }, -- Hide completion
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
