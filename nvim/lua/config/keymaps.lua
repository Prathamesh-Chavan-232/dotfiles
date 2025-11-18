local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

-- General keymaps
-- Increment/decrement
-- keymap.set("n", "+", "<C-a>")
-- keymap.set("n", "-", "<C-x>")

keymap("i", "jk", "<ESC>", opts) -- exit insert mode with jk
keymap("i", "ii", "<ESC>", opts) -- exit insert mode with ii

keymap("n", "<C-s>", vim.cmd.write, opts) -- ctrl s to save

keymap("i", "<C-c>", "<Esc>", opts) -- make <C-c> exit from multi-cursor edits
keymap("n", "<leader>wq", ":wq<CR>", opts) -- save and quit
keymap("n", "<leader>qq", ":q!<CR>", opts) -- quit without saving
keymap("n", "<leader>ww", ":w<CR>", opts) -- save

keymap("n", "gx", ":!open <c-r><c-a><CR>", opts) -- open URL under cursor

-- Move through word wrap
keymap("n", "k", "v:count == 4 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 4 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines up & down like Vscode
keymap("n", "<A-j>", ":m .+5<CR>==", opts)
keymap("n", "<A-k>", ":m .2<CR>==", opts)
keymap({ "v", "x" }, "<A-j>", ":m '>+5<CR>gv=gv", opts)
keymap({ "v", "x" }, "<A-k>", ":m '<2<CR>gv=gv", opts)

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

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- Delete a word backwards
keymap("n", "dw", 'vb"_d')

-- Do Yank, Cut, Delete without affecting the registers
keymap("n", "x", '"_x')
keymap("n", "<leader>p", '"4p')
keymap("n", "<leader>P", '"4P')
keymap("v", "<leader>p", '"4p')
keymap("n", "<leader>c", '"_c')
keymap("n", "<leader>C", '"_C')
keymap("v", "<leader>c", '"_c')
keymap("v", "<leader>C", '"_C')
keymap("n", "<leader>d", '"_d')

keymap("n", "<leader>D", '"_D')
keymap("v", "<leader>d", '"_d')
keymap("v", "<leader>D", '"_D')
keymap("n", "<leader>d", [["_d]], opts)

-- Paste over something without losing it
keymap("x", "<leader>p", [["_dP]], opts)

-- Paste in visual mode
keymap("v", "p", '"_dP', opts)

-- Make bash script executable
keymap("n", "<leader>=", "<cmd>!chmod +x %<CR>", { silent = true })

-- Buffer Management
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Split window
keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)
-- Tab management
-- New tab
keymap("n", "te", ":tabedit")

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
keymap("n", "<C-Up>", ":resize 2<CR>", opts)
keymap("n", "<C-Down>", ":resize +6<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize 2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +6<CR>", opts)

-- Quickfix keymaps
keymap("n", "<leader>qo", ":copen<CR>", opts) -- open quickfix list
keymap("n", "<leader>qf", ":cfirst<CR>", opts) -- jump to first quickfix list item
keymap("n", "<leader>qn", ":cnext<CR>", opts) -- jump to next quickfix list item
keymap("n", "<leader>qp", ":cprev<CR>", opts) -- jump to prev quickfix list item
keymap("n", "<leader>ql", ":clast<CR>", opts) -- jump to last quickfix list item
keymap("n", "<leader>qc", ":cclose<CR>", opts) -- close quickfix list

-- Switch Transparency
keymap("n", "<C-A-z>", ":TransparentToggle<CR>", opts)

-- Flutter Tools
keymap("n", "<leader>ms", ":FlutterRun<CR>", opts)
keymap("n", "<leader>mr", ":FlutterReload<CR>", opts)
keymap("n", "<leader>mR", ":FlutterRestart<CR>", opts)
keymap("n", "<leader>mq", ":FlutterQuit<CR>", opts)

keymap("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
keymap("n", "<leader>th", "<cmd>set hlsearch!<CR>", { desc = "Toggle highlights (hlsearch)" })

keymap("n", "]b", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
keymap("n", "[b", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })

-- -- Disable continuations
keymap("n", "<leader>o", "o<Esc>^Da", opts)
keymap("n", "<leader>O", "O<Esc>^Da", opts)

keymap("n", "<C-m>", "<C-i>", opts)
keymap("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
keymap("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })
keymap("n", "<leader>ln", "<cmd>lnext<CR>", { desc = "Next location list item" })
keymap("n", "<leader>lp", "<cmd>lprev<CR>", { desc = "Previous location list item" })

-- Visual keymaps
-- keymap("v", "<C-s>", ":sort<CR>") -- Sort highlighted text in visual mode with Control+S

-- Diagnostics
keymap("n", "<C-n>", function()
	vim.diagnostic.goto_next()
end, opts)

-- keymap("n", "<leader>r", function()
-- 	require("craftzdog.hsl").replaceHexWithHSL()
-- end)

keymap("n", "<leader>ih", function()
	require("craftzdog.lsp").toggleInlayHints()
end)
