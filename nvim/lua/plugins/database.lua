return {
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		keys = {
			{ "<leader>du", ":DBUIToggle<cr>", desc = "Toggle DB UI" },
			{ "<leader>db", ":DBUIFindBuffer<cr>", desc = "DB Find buffer" },
			{
				"<leader>dr",
				":DBUIRenameBuffer<cr>",
				desc = "DB Rename buffer",
			},
			{ "<leader>dl", ":DBUILastQueryInfo<cr>", desc = "DB Last query" },
		},
		config = function()
			local function db_completion()
				require("plugins.completion.cmp").setup.buffer({
					sources = { { name = "vim-dadbod-completion" } },
				})
			end

			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
				},
				command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
					"mysql",
					"plsql",
				},
				callback = function()
					vim.schedule(db_completion)
				end,
			})
		end,
		cmd = {
			"DBUIToggle",
			"DBUI",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUIRenameBuffer",
			"DBUILastQueryInfo",
		},
	},
}
