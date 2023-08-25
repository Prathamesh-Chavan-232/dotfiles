local options = {
  -- general editor settings
  mouse = "a",        -- "" disables mouse
  guicursor = "",    -- fat vim cursor at all times
  cursorline = true, -- highlight the current line
  cmdheight = 2,     -- more space in the neovim command line for displaying messages
  showmode = false,  -- show things like -- INSERT --
  clipboard = "unnamedplus",                        -- neovim uses the system clipboard

  -- text wrap
  wrap = false,

  -- line numbers
  number = true,         -- set numbered lines
  relativenumber = true, -- set relative line numbers
  numberwidth = 2,       -- set number column width to 2 {default 4}

  writebackup = false,   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  backup = false,        -- create a backup file
  swapfile = false,      -- create a swapfile

  -- tabs & spaces
  showtabline = 2, -- always show tabs
  tabstop = 2,     -- tabspace = 4 spaces
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,   -- convert tabs to spaces
  smartindent = true, -- make indenting smarter again

  -- splits
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  -- undo & undotree
  undofile = true,                                -- enable persistent undo
  undodir = os.getenv("HOME") .. "/.vim/undodir", -- enable undotree

  -- searching
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = false,       -- highlight all matches on previous search pattern
  incsearch = true,       -- incremental search
  ignorecase = true,      -- ignore case in search patterns
  smartcase = true,       -- smart case

  -- completion
  updatetime = 300,                        -- faster completion (4000ms default)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  completeopt = { "menuone", "noselect" }, -- Set completeopt to have a better completion experience

  -- appearance
  termguicolors = true, -- set term gui colors (most terminals support this)
  conceallevel = 0,     -- so that `` is visible in markdown files
  -- guifont = "monospace:h20", -- the font used in graphical neovim applications
  signcolumn = "yes",   -- always show the sign column, otherwise it would shift the text each time

  -- accesibility
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.shortmess = "ilmnrx"                       -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append "c" -- don't give |ins-completion-menu| messages
vim.opt.isfname:append("@-@")
vim.opt.iskeyword:append "-" -- hyphenated words recognized by searches
