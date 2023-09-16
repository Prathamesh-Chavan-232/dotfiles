-- Shorten function name
local keymap = vim.keymap.set

-- [[ Custom Keymaps ]]
-- Leader key
local opts = { noremap = true, silent = true }
keymap("", "<Space>", "<Nop>", opts)

local term_opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Buffers
-- ctrl s to save
keymap("n", "<C-s>", vim.cmd.write, opts)
-- close buffer
keymap("n", "<leader>x", vim.cmd.bd, opts)
-- navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Splits
-- better window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tabs
keymap("n", "<T-l>", ":bnext<CR>", opts)
keymap("n", "<T-h>", ":bprevious<CR>", opts)

-- Switch tmux sessions (requires tmux-sessionizer)
-- keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- Code Formatting (requires lsp)
keymap("n", "<A-F>", vim.lsp.buf.format, opts)

-- Text Wrap
-- toggle text wrap
keymap("n", "<A-z>", ":set wrap!<CR>", opts)
-- remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines up & down like Vscode
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap({ "v", "x" }, "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap({ "v", "x" }, "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Cursor
-- keep cursor at same place on J
keymap("n", "J", "mzJ`z", opts)
-- keep cursor centered while moving
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Quick fix list
keymap("n", "<leader-K>", "<cmd>cnext<CR>zz", opts)
keymap("n", "<leader-J>", "<cmd>cprev<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- Commands
-- make bash script executable
keymap("n", "<leader>\\", "<cmd>!chmod +x %<CR>", { silent = true }, opts)

-- Insert Mode --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
-- make <C-c> exit from multi-cursor edits
keymap("i", "<C-c>", "<Esc>")

-- Stay in visual mode while indenting
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Yank,delete,paste, find & replace
-- replace current word
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>Y", '"+Y', opts)
-- paste over something without losing it
keymap("x", "<leader>p", [["_dP]], opts)
-- Paste in visual mode
keymap("v", "p", '"_dP', opts)
-- delete losing previous yank
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Terminal Mode --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

