-- Shorten function name
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Set leader key to space
vim.g.mapleader = " "

-- General keymaps
keymap("n", "gx", ":!open <c-r><c-a><CR>", opts) -- open URL under cursor
keymap("i", "jk", "<ESC>", opts) -- exit insert mode with jk
keymap("i", "kj", "<ESC>", opts) -- exit insert mode with kj
keymap("i", "ii", "<ESC>", opts) -- exit insert mode with ii
keymap("i", "<C-c>", "<Esc>", opts) -- make <C-c> exit from multi-cursor edits
keymap("n", "<C-s>", vim.cmd.write, opts) -- ctrl s to save
keymap("n", "<leader>wq", ":wq<CR>", opts) -- save and quit
keymap("n", "<leader>qq", ":q!<CR>", opts) -- quit without saving
keymap("n", "<leader>ww", ":w<CR>", opts) -- save
keymap(
	"n",
	"<C-w>",
	[[:lua if #vim.fn.getbufinfo({buflisted = 1}) > 1 then vim.cmd('bp|bd #') else vim.cmd('enew|bd #') end<CR>]],
	opts
)

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
