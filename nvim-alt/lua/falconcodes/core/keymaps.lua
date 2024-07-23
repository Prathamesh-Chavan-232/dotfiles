-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Set leader key to space
vim.g.mapleader = " "

-- General keymaps
keymap("i", "jk", "<ESC>", opts) -- exit insert mode with jk
keymap("i", "kj", "<ESC>", opts) -- exit insert mode with kj
keymap("i", "ii", "<ESC>", opts) -- exit insert mode with ii
keymap("i", "<C-c>", "<Esc>", opts) -- make <C-c> exit from multi-cursor edits
keymap("n", "<C-s>", vim.cmd.write, opts) -- ctrl s to save
keymap("n", "<leader>wq", ":wq<CR>", opts) -- save and quit
keymap("n", "<leader>qq", ":q!<CR>", opts) -- quit without saving
keymap("n", "<leader>ww", ":w<CR>", opts) -- save
keymap("n", "gx", ":!open <c-r><c-a><CR>", opts) -- open URL under cursor

-- Move through word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines up & down like Vscode
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap({ "v", "x" }, "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap({ "v", "x" }, "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor at same place on J
keymap("n", "J", "mzJ`z", opts)

-- keep cursor centered while moving
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Visual Mode indenting
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Toggle text wrap
keymap("n", "<A-z>", ":set wrap!<CR>", opts)

-- Clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- Replace current word
keymap("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>Y", '"+Y', opts)

-- Delete without losing previous yank
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Paste over something without losing it
keymap("x", "<leader>p", [["_dP]], opts)

-- Paste in visual mode
keymap("v", "p", '"_dP', opts)

-- Make bash script executable
keymap("n", "<leader>=", "<cmd>!chmod +x %<CR>", { silent = true })

-- Buffer Management
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bclose<CR>", opts)

-- Tab management
keymap("n", "<leader>to", ":tabnew<CR>", opts) -- open a new tab
keymap("n", "<leader>td", ":tabclose<CR>", opts)
keymap("n", "<leader>tn", ":tabn<CR>", opts) -- next tab
keymap("n", "<leader>tp", ":tabp<CR>", opts) -- previous tab
keymap("n", "<tab>", ":tabn<CR>", opts)
keymap("n", "<S-tab>", ":tabp<CR>", opts)

-- Split windows management
keymap("n", "<leader>sv", ":vsp<CR>", opts) -- split window vertically
keymap("n", "<leader>sh", ":sp<CR>", opts) -- split window horizontally
keymap("n", "<leader>sd", ":close<CR>", opts) -- close split window
keymap("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width

-- Resize window with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Diff keymaps
keymap("n", "<leader>cc", ":diffput<CR>", opts) -- put diff from current to other during diff
keymap("n", "<leader>cj", ":diffget 1<CR>", opts) -- get diff from left (local) during merge
keymap("n", "<leader>ck", ":diffget 3<CR>", opts) -- get diff from right (remote) during merge
keymap("n", "<leader>cn", "]c", opts) -- next diff hunk
keymap("n", "<leader>cp", "[c", opts) -- previous diff hunk

-- Quickfix keymaps
keymap("n", "<leader>qo", ":copen<CR>", opts) -- open quickfix list
keymap("n", "<leader>qf", ":cfirst<CR>", opts) -- jump to first quickfix list item
keymap("n", "<leader>qn", ":cnext<CR>", opts) -- jump to next quickfix list item
keymap("n", "<leader>qp", ":cprev<CR>", opts) -- jump to prev quickfix list item
keymap("n", "<leader>ql", ":clast<CR>", opts) -- jump to last quickfix list item
keymap("n", "<leader>qc", ":cclose<CR>", opts) -- close quickfix list

-- Vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- toggle maximize tab

-- Nvim-tree
keymap("n", "<leader>ee", ":NvimTreeToggle<CR>", opts) -- toggle file explorer
keymap("n", "<leader>er", ":NvimTreeFocus<CR>", opts) -- toggle focus to file explorer
keymap("n", "<leader>ef", ":NvimTreeFindFile<CR>", opts) -- find file in file explorer

-- Telescope
keymap("n", "<leader>ff", require("telescope.builtin").find_files, opts)
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
keymap("n", "<leader>fb", require("telescope.builtin").buffers, opts)
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, opts)
keymap("n", "<leader>fs", require("telescope.builtin").current_buffer_fuzzy_find, opts)
keymap("n", "<leader>fo", require("telescope.builtin").lsp_document_symbols, opts)
keymap("n", "<leader>fi", require("telescope.builtin").lsp_incoming_calls, opts)
keymap("n", "<leader>fm", function()
	require("telescope.builtin").treesitter({ default_text = ":method:" })
end, opts)

-- Git-blame
keymap("n", "<leader>gb", ":GitBlameToggle<CR>", opts) -- toggle git blame

-- Harpoon
keymap("n", "<leader>ha", require("harpoon.mark").add_file, opts)
keymap("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, opts)
keymap("n", "<leader>h1", function()
	require("harpoon.ui").nav_file(1)
end, opts)
keymap("n", "<leader>h2", function()
	require("harpoon.ui").nav_file(2)
end, opts)
keymap("n", "<leader>h3", function()
	require("harpoon.ui").nav_file(3)
end, opts)
keymap("n", "<leader>h4", function()
	require("harpoon.ui").nav_file(4)
end, opts)
keymap("n", "<leader>h5", function()
	require("harpoon.ui").nav_file(5)
end, opts)
keymap("n", "<leader>h6", function()
	require("harpoon.ui").nav_file(6)
end, opts)
keymap("n", "<leader>h7", function()
	require("harpoon.ui").nav_file(7)
end, opts)
keymap("n", "<leader>h8", function()
	require("harpoon.ui").nav_file(8)
end, opts)
keymap("n", "<leader>h9", function()
	require("harpoon.ui").nav_file(9)
end, opts)

-- Vim REST Console
keymap("n", "<leader>xr", ":call VrcQuery()<CR>", opts) -- Run REST query

-- LSP
keymap("n", "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "rr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
keymap("v", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>tr", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("i", "<C-Space>", "<cmd>lua vim.lsp.buf.completion()<CR>", opts)
keymap("n", "<A-F>", vim.lsp.buf.format, opts) -- Code Format

-- Debugging
keymap("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
keymap(
	"n",
	"<leader>bl",
	"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	opts
)
keymap("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", opts)
keymap("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dd", function()
	require("dap").disconnect()
	require("dapui").close()
end, opts)
keymap("n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end, opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end, opts)
keymap("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, opts)
keymap("n", "<leader>df", "<cmd>Telescope dap frames<cr>", opts)
keymap("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", opts)
keymap("n", "<leader>de", function()
	require("telescope.builtin").diagnostics({ default_text = ":E:" })
end, opts)

-- Transparent Toggle
keymap("n", "<C-A-z>", ":TransparentToggle<CR>", opts)

-- Flutter Tools
keymap("n", "<leader>ms", ":FlutterRun<CR>", opts)
keymap("n", "<leader>mr", ":FlutterReload<CR>", opts)
keymap("n", "<leader>mR", ":FlutterRestart<CR>", opts)
keymap("n", "<leader>mq", ":FlutterQuit<CR>", opts)
