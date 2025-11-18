return {
	"neovim/nvim-lspconfig",
	cmd = { "LspStart" },
	dependencies = {
		"folke/lazydev.nvim",
		"pmizio/typescript-tools.nvim",
		"Bilal2453/luvit-meta",
		"SmiteshP/nvim-navic",
		"b0o/SchemaStore.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfiguser = require("configs.lsp")
		lspconfiguser.setup_diagnostic_config()
		lspconfiguser.setup_handlers()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("lspconfig.ui.windows").default_options.border = "single"

		local servers = require("configs.lsp.servers").to_setup
		for _, server in pairs(servers) do
			local server_opts = {
				on_attach = lspconfiguser.on_attach,
				capabilities = capabilities,
			}

			local has_custom_opts, server_custom_opts = pcall(require, "configs.lsp.settings." .. server)
			if has_custom_opts then
				server_opts = vim.tbl_deep_extend("force", server_opts, server_custom_opts)
			end

			local has_custom_commands, server_custom_commands = pcall(require, "configs.lsp.commands." .. server)
			if has_custom_commands then
				server_opts.commands = server_custom_commands
			end

			vim.lsp.config[server].setup(server_opts)
		end
	end,
}
