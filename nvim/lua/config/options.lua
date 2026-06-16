-- General editor options.
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false -- statusline shows the mode
opt.clipboard = "unnamedplus" -- use the system clipboard

opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 400

opt.splitright = true
opt.splitbelow = true
opt.inccommand = "split" -- live preview of :substitute
opt.cursorline = true
opt.scrolloff = 8
opt.termguicolors = true

-- Indentation: 2 spaces by default.
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.wrap = false
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.pumheight = 12 -- max items shown in the completion popup
opt.confirm = true -- ask to save instead of failing on :q with unsaved changes
opt.fillchars = { eob = " " }
