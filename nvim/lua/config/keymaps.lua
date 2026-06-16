-- General keymaps. LSP/plugin-specific maps live in their own modules.
local map = vim.keymap.set

-- Exit insert mode without reaching for Esc.
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "ii", "<Esc>", { desc = "Exit insert mode" })

-- Save / quit.
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Clear search highlight.
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation handled by vim-tmux-navigator (<C-h/j/k/l>).

-- Splits. (`s` itself is flash-jump, so splits live under <leader>s.)
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

-- Resize windows with arrows.
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffers.
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Move lines (VSCode-style).
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered on jumps.
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Stay in indent mode.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Delete to the black-hole register without clobbering the unnamed one.
-- (<leader>d is the which-key "debug" group prefix, so use <leader>D here.)
map({ "n", "v" }, "<leader>D", [["_d]], { desc = "Delete (no yank)" })
map("x", "<leader>p", [["_dP]], { desc = "Paste (keep register)" })

-- (Line diagnostics float is on <leader>cd via LSP; <leader>e is neo-tree.)
