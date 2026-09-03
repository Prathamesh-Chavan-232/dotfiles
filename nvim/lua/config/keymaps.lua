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
map("n", "<leader>bd", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

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
-- Clear search highlights
map("n", "<leader>nh", ":nohl<CR>")

-- Replace current word
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>Y", '"+Y')

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Delete a word backwards
map("n", "dw", 'vb"_d')

-- Do Yank, Cut, Delete without affecting the registers
map("n", "x", '"_x')
map("n", "<leader>p", '"4p')
map("n", "<leader>P", '"4P')
map("v", "<leader>p", '"4p')
map("n", "<leader>c", '"_c')
map("n", "<leader>C", '"_C')
map("v", "<leader>c", '"_c')
map("v", "<leader>C", '"_C')
map("n", "<leader>d", '"_d')

map("n", "<leader>D", '"_D')
map("v", "<leader>d", '"_d')
map("v", "<leader>D", '"_D')
map("n", "<leader>d", [["_d]])

-- Paste in visual mode
map("v", "p", '"_dP')

-- Paste over something without losing it
-- map("x", "<leader>p", [["_dP]])

-- Make bash script executable
map("n", "<leader>=", "<cmd>!chmod +x %<CR>", { silent = true })

-- Quickfix maps
map("n", "<leader>qo", ":copen<CR>") -- open quickfix list
map("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
map("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
map("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
map("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
map("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Switch Transparency
map("n", "<C-A-z>", ":TransparentToggle<CR>")

-- -- Disable continuations
map("n", "<leader>o", "o<Esc>^Da")
map("n", "<leader>O", "O<Esc>^Da")

map("n", "<C-m>", "<C-i>")
map("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
map("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })
map("n", "<leader>ln", "<cmd>lnext<CR>", { desc = "Next location list item" })
map("n", "<leader>lp", "<cmd>lprev<CR>", { desc = "Previous location list item" })

-- Visual maps
-- map("v", "<C-s>", ":sort<CR>") -- Sort highlighted text in visual mode with Control+S

-- Close buffer in normal mode (Ctrl+W deletes word in insert mode by default)
map("n", "<C-w>", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

-- map("n", "<leader>r", function()
-- 	require("craftzdog.hsl").replaceHexWithHSL()
-- end)

