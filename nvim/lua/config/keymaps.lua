-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- [[ Custom Keymaps ]]

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

-- navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap(
  "n",
  "<C-w>",
  [[:lua if #vim.fn.getbufinfo({buflisted = 1}) > 1 then vim.cmd('bp|bd #') else vim.cmd('enew|bd #') end<CR>]],
  opts
)

-- Tabs
keymap("n", "<leader>te", ":tabedit<CR>", opts)
keymap("n", "<tab>", ":tabnext<CR>", opts)
keymap("n", "<S-tab>", ":tabprev<CR>", opts)

-- Splits
keymap("n", "<leader>sv", ":vsp<CR>", opts)
keymap("n", "<leader>sh", ":sp<CR>", opts)

-- resize with arrows
keymap("n", "<C-Up>", ":resize -1<CR>", opts)
keymap("n", "<C-Down>", ":resize +1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +1<CR>", opts)

-- Text Wrap
-- toggle text wrap
keymap("n", "<A-z>", ":set wrap!<CR>", opts)

keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- remap for dealing with word wrap
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines up & down like Vscode
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap({ "v", "x" }, "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap({ "v", "x" }, "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Code Formatting (requires lsp)
keymap("n", "<A-F>", vim.lsp.buf.format, opts)

-- Cursor
-- keep cursor at same place on J
keymap("n", "J", "mzJ`z", opts)
-- keep cursor centered while moving
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Yank, delete, paste, find & replace
-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>Y", '"+Y', opts)
-- delete without losing previous yank
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)
-- paste over something without losing it
keymap("x", "<leader>p", [["_dP]], opts)
-- Paste in visual mode
keymap("v", "p", '"_dP', opts)

-- Stay in visual mode while indenting
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
-- make <C-c> exit from multi-cursor edits
keymap("i", "<C-c>", "<Esc>")

-- Commands
-- make bash script executable
keymap("n", "<leader>=", "<cmd>!chmod +x %<CR>", opts)

-- Switch Transparency
keymap("n", "<C-A-z>", ":TransparentToggle<CR>", opts)

-- Flutter Tools
keymap("n", "<leader>ms", ":FlutterRun<CR>", opts)
keymap("n", "<leader>mr", ":FlutterReload<CR>", opts)
keymap("n", "<leader>mR", ":FlutterRestart<CR>", opts)
keymap("n", "<leader>mq", ":FlutterQuit<CR>", opts)
