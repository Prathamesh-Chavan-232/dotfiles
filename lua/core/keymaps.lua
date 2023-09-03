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

-- Normal --
-- Ctrl S to save
keymap("n", "<C-s>", vim.cmd.write, opts)
-- Close buffer
keymap("n", "<leader>x", vim.cmd.bd, opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Keep cursor at same place on J
keymap("n", "J", "mzJ`z", opts)

-- Keep cursor centered while moving
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- format code (requires lsp)
keymap("n", "<leader>f", vim.lsp.buf.format, opts)

-- quick fix (clashes with harpoon)
keymap("n", "<leader-K>", "<cmd>cnext<CR>zz", opts)
keymap("n", "<leader-J>", "<cmd>cprev<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- replace current word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- make bash script executable
keymap("n", "<leader>\\", "<cmd>!chmod +x %<CR>", { silent = true }, opts)

-- switch tmux sessions
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- yank to system clipboard
keymap({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)
-- delete losing previous yank
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- make <C-c> exit from multi-cursor edits
keymap("i", "<C-c>", "<Esc>")

-- Visual --
-- Stay in visual mode while indenting
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)
-- Paste in visual mode
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- paste over something without losing it
keymap("x", "<leader>p", [["_dP]], opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Mixed --
-- Move lines up & down like Vscode
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

