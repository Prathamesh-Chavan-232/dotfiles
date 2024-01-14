return {

	"folke/which-key.nvim",
	dependencies = {
		"akinsho/toggleterm.nvim",
	},

	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")
		-- border
		wk.setup({
			window = {
				border = "double",
			},
		})

		local terminal = require("toggleterm.terminal").Terminal

		local toggle_float = function()
			local float = terminal:new({ direction = "float" })
			return float:toggle()
		end

		local toggle_lazygit = function()
			local lazygit = terminal:new({ cmd = "lazygit", direction = "float" })
			return lazygit:toggle()
		end

		-- Keymaps
		local mappings = {
			-- Basic Operations
			q = { ":q<cr>", "Quit File" },
			Q = { ":q!<cr>", "Force Quit File" },
			w = { ":w<cr>", "Save File" },
			W = { ":w!<cr>", "Force Save File" },

			-- Buffers
			x = { ":bdelete<cr>", "Close Buffer" },

			-- NvimTree
			e = { ":NvimTreeToggle<cr>", "NvimTreeToggle" },

			-- -- Telescope
			-- f = {
			-- 	name = "Telescope",
			-- 	f = { ":Telescope find_files theme=ivy<cr>", "Telescope find_files" },
			-- 	w = { ":Telescope current_buffer_fuzzy_find theme=ivy<cr>", "Fuzzy Find in File" },
			-- 	o = { ":Telescope oldfiles theme=ivy<cr>", "Telescope oldfiles" },
			-- 	g = { ":Telescope live_grep theme=ivy<cr>", "Telescope live_grep" },
			-- 	r = { ":Telescope resume theme=ivy<cr>", "Telescope resume" },
			-- 	b = { ":Telescope buffers theme=ivy<cr>", "Telescope buffers" },
			-- },

			-- Lsp Stuffs
			l = {
				name = "LSP",
				i = { ":LspInfo<cr>", "Connected Language Servers" },
				k = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
				K = { "<cmd>Lspsaga hover_doc<cr>", "Hover Commands" },
				w = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace Folder" },
				W = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace Folder" },
				l = {
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
					"List Workspace Folders",
				},
				t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
				d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition" },
				D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
				r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
				R = { "<cmd>Lspsaga rename<cr>", "Rename" },
				a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
				e = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Show Line Diagnostics" },
				n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Go To Next Diagnostic" },
				N = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Go To Previous Diagnostic" },
			},
			-- Terminal
			t = {
				name = "Terminal",
				-- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
				-- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
				-- t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
				-- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
				f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
				h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
				v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
			},

			-- Code Formatting
			F = {
				name = "Code Formoat",
				M = { ":lua vim.lsp.buf.format()<cr>", "Format code" },
			},
		}

		local opts = { prefix = "<leader>" }
		wk.register(mappings, opts)
	end,
}
