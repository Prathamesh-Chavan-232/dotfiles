-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local options = {
  -- UI features --
  title = true, -- set the title of the window to the file name
  guicursor = "", -- fat cursor
  -- menus
  pumheight = 10, -- height of the pop up menu
  showcmd = true, -- show command in the bottom right
  cmdheight = 0, -- set command line height -> 0 hides the command line unless its being used

    -- line numbers
    numberwidth = 4, -- set number column {default 4}

    -- tabs & spaces
    tabstop = 4,      -- 1 tabspace = ? spaces
    shiftwidth = 4,   -- number of spaces inserted for indentation
    softtabstop = 4,  -- 1 tabspace in insert mode
    expandtab = true, -- convert spaces to tabs

    -- indents
    autoindent = true,  -- set auto indenting
    smartindent = true, -- make indenting smarter again
    breakindent = true, -- wrap indent to match line start

    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    conceallevel = 0,   -- so that `` is visible in markdown files
    -- fillchars = { eob = " " }, -- disable `~` on nonexistent lines

    -- Editor behaviour --
    mouse = "",                               -- set mouse usuage "" disables mouse
    history = 100,                            -- number of commands to remember in a history table
    virtualedit = "block",                    -- allow going past end of line in visual block mode
    backspace = { "start", "eol", "indent" }, -- makes backspace work properly
    -- clipboard = "unnamedplus", -- make neovim use the system clipboard

    -- searching
    hlsearch = true,   -- highlight all matches on previous search pattern
    incsearch = true,  -- incremental search
    ignorecase = true, -- ignore case in search patterns
    infercase = true,  -- infer cases in keyword completion
    smartcase = true,  -- smart case

    -- encoding
    fileencoding = "utf-8", -- the encoding written to a file

    -- scrolling & text wrap
    scrolloff = 8,     -- number of lines to keep above and below the cursor
    sidescrolloff = 8, -- number of columns to keep at the sides of the cursor
    wrap = false,      -- set text wrap (disregrads the previous setting, best to set a keybind, wrap is very disorienting)

    -- buffers,tabs & splits
    showtabline = 2,   -- always show tabs
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window

    -- undo & undotree
    undofile = true,                                -- enable persistent undo
    undodir = os.getenv("HOME") .. "/.vim/undodir", -- enable undotree

    -- swap and backup
    writebackup = false, -- handle files that are edited by another program simulatenously
    backup = false,      -- set backup file
    swapfile = false,    -- set swapfile
}

-- opts
for setting, value in pairs(options) do
    vim.opt[setting] = value
end

vim.opt.path:append("**") -- add recursive file search
vim.opt.wildignore:append({ ".git", "node_modules", "dist", "build" }) -- ignore these files in wildmenu
vim.opt.formatoptions:append({ "r" }) -- autoformat options
vim.opt.shortmess = "ilmnrx" -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
vim.opt.isfname:append("@-@") -- make words with - a single word
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches

vim.opt.shortmess:append({ s = true, I = true, F = true }) -- disable search count wrap and startup messages
vim.opt.backspace:append({ "nostop" })                     -- don't stop backspace at insert
