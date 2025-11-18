local running_kitty = os.getenv("TERM") == "xterm-kitty"

local kitty = require("configs.kitty")

-- better space
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "Use jk to enter in normal mode" }) -- exit insert mode with jk
vim.keymap.set("i", "kj", "<ESC>", { noremap = true, silent = true }) -- exit insert mode with kj
vim.keymap.set("i", "ii", "<ESC>", { noremap = true, silent = true }) -- exit insert mode with ii
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true }) -- make <C-c> exit from multi-cursor edits

-- save
vim.keymap.set("n", "<C-s>", vim.cmd.write, { noremap = true, silent = true }) -- ctrl s to save
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { noremap = true, silent = true }) -- save and quit
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { noremap = true, silent = true }) -- quit without saving
vim.keymap.set("n", "<leader>ww", ":w<CR>", { noremap = true, silent = true }) -- save

-- buffers
vim.keymap.set("n", "<leader>bd", ":bd!<cr>", { silent = true, desc = "Delete current buffer" })

-- close buffers
vim.keymap.set(
	"n",
	"<C-w>",
	[[:lua if #vim.fn.getbufinfo({buflisted = 1}) > 1 then vim.cmd('bp|bd #') else vim.cmd('enew|bd #') end<CR>]],
	{ noremap = true, silent = true, desc = "Delete current buffer" }
)
vim.keymap.set({ "n", "o", "x" }, "<s-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- split buffers
vim.keymap.set("n", "<leader>sv", ":vsp<CR>", { noremap = true, silent = true }) -- split window vertically
vim.keymap.set("n", "<leader>sh", ":sp<CR>", { noremap = true, silent = true }) -- split window horizontally
vim.keymap.set("n", "<leader>sd", ":close<CR>", { noremap = true, silent = true }) -- close split window
vim.keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true }) -- make split windows equal width

-- move cursor between windows
vim.keymap.set("n", "<C-h>", running_kitty and function()
	kitty.nav("h")
end or "<C-w>h", { desc = "Move the cursor to the window on the left" })
vim.keymap.set("n", "<C-j>", running_kitty and function()
	kitty.nav("j")
end or "<C-w>j", { desc = "Move the cursor to the window below" })
vim.keymap.set("n", "<C-k>", running_kitty and function()
	kitty.nav("k")
end or "<C-w>k", { desc = "Move the cursor to the window above" })
vim.keymap.set("n", "<C-l>", running_kitty and function()
	kitty.nav("l")
end or "<C-w>l", { desc = "Move the cursor to the window on the right" })

-- resize
vim.keymap.set("n", "<C-Up>", ":resize -2<cr>", { silent = true, desc = "Resize window vertically" })
vim.keymap.set("n", "<C-Down>", ":resize +2<cr>", { silent = true, desc = "Resize window vertically" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", { silent = true, desc = "Resize window horizontally" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", { silent = true, desc = "Resize window horizontally" })

-- tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { noremap = true, silent = true }) -- open a new tab
vim.keymap.set("n", "<leader>td", ":tabclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { noremap = true, silent = true }) -- next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { noremap = true, silent = true }) -- previous tab
vim.keymap.set("n", "<tab>", ":tabn<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-tab>", ":tabp<CR>", { noremap = true, silent = true })

-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to clipboard" })

-- search
vim.keymap.set("n", "<leader>nh", ":nohlsearch<cr>", { silent = true, desc = "Don't highlight the current search" })

-- replace current word
vim.keymap.set(
	"n",
	"<leader>sr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ noremap = true, silent = true }
)

-- insert and remove quotes
vim.keymap.set("n", "<leader>sq", "ciw'<C-r>\"'<esc>", { silent = true, noremap = true, desc = "Insert single quotes" })
vim.keymap.set("n", "<leader>usq", "di'hPl2x", { silent = true, noremap = true, desc = "Remove single quotes" })
vim.keymap.set("n", "<leader>dq", 'ciw"<C-r>""<esc>', { silent = true, noremap = true, desc = "Insert double quotes" })
vim.keymap.set("n", "<leader>udq", 'di"hPl2x', { silent = true, noremap = true, desc = "Remove double quotes" })
vim.keymap.set("v", "<leader>sq", "xi'<esc>pA'<esc>", {
	silent = true,
	noremap = true,
	desc = "Insert single quotes in visual mode",
})
vim.keymap.set("v", "<leader>dq", 'xi"<esc>pA"<esc>', {
	silent = true,
	noremap = true,
	desc = "Insert double quotes in visual mode",
})

-- word wrap
vim.keymap.set("n", "<leader>sw", function()
	if vim.o.wrap then
		vim.cmd("set nowrap")
	else
		vim.cmd("set wrap")
	end
end, { desc = "Switch wrap" })
vim.keymap.set("n", "<A-z>", ":set wrap!<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ch", function()
	vim.opt.cmdheight = vim.o.cmdheight == 0 and 1 or 0
end, { silent = true, desc = "Switch cmdheight between 1 and 0" })

-- yank

-- Delete without losing previous yank
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { noremap = true, silent = true })

-- Paste over something without losing it
vim.keymap.set("x", "<leader>p", [["_dP]], { noremap = true, silent = true })

-- Paste in visual mode
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- terminal
vim.keymap.set("n", "<leader>tv", [[<cmd>vsplit | term<cr>A]], { desc = "Open terminal in vertical split" })
vim.keymap.set("n", "<leader>th", [[<cmd>split | term<cr>A]], { desc = "Open terminal in horizontal split" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Use jk to enter in terminal normal mode" })

-- useful stuff
vim.keymap.set("n", "gx", ":!open <c-r><c-a><CR>", { noremap = true, silent = true }) -- open URL under cursor

vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

vim.keymap.set("n", "<leader>fc", "<cmd>foldclose<cr>")

-- keep cursor at same place on J
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true })

-- keep cursor centered while moving
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Visual Mode indenting
vim.keymap.set("v", "<", "<gv^", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv^", { noremap = true, silent = true })

-- Move through word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines up & down like Vscode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set({ "v", "x" }, "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set({ "v", "x" }, "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- quickfix list
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { noremap = true, silent = true }) -- open quickfix list
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>", { noremap = true, silent = true }) -- jump to first quickfix list item
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { noremap = true, silent = true }) -- jump to next quickfix list item
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { noremap = true, silent = true }) -- jump to prev quickfix list item
vim.keymap.set("n", "<leader>ql", ":clast<CR>", { noremap = true, silent = true }) -- jump to last quickfix list item
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { noremap = true, silent = true }) -- close quickfix list

-- diagnostics
vim.keymap.set("n", "<leader>dd", function()
	vim.diagnostic.setloclist()
end, { desc = "Show buffer diagnostics" })

vim.keymap.set("n", "<leader>wd", function()
	vim.diagnostic.setqflist()
end, { desc = "Show workspace diagnostics" })

-- toggle dark mode
vim.keymap.set("n", "<leader>sb", function()
	vim.opt.background = vim.o.background == "dark" and "light" or "dark"
	if running_kitty then
		local cmd = "kitten themes --cache-age=-1 " .. vim.o.background
		vim.fn.system(cmd)
	end
end, { desc = "Switch background" })
