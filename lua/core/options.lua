local options = {
    -- ui & general editor options
    cmdheight = 1,             -- command line height -> 0 hides the command line unless its being used
    guicursor = "",            -- fat vim cursor at all times
    cursorline = true,         -- highlight the current line
    showmode = false,          -- show things like -- INSERT --
    showtabline = 2,           -- always show tabs
    pumheight = 10,            -- height of the pop up menu
    laststatus = 3,            -- global statusline
    -- clipboard = "unnamedplus", -- neovim uses the system clipboard
    virtualedit = "block",     -- allow going past end of line in visual block mode
    mouse = "a",                -- "" disables mouse
    history = 100,             -- number of commands to remember in a history table

    -- scrolling & text wrap
    -- sidescroll = 8, -- set to 0 or a large value keeps cursor centered on long lines
    sidescrolloff = 8, -- number of columns to keep at the sides of the cursor
    scrolloff = 8,     -- number of lines to keep above and below the cursor
    wrap = false,

    -- line numbers
    number = true,         -- set numbered lines
    relativenumber = true, -- set relative line numbers
    numberwidth = 4,       -- set number column {default 4}

    writebackup = false,   -- handle files that are edited by another program simulatenously
    backup = false,        -- set backup file
    swapfile = false,      -- set swapfile

    -- indents, tabs & spaces
    linebreak = true,   -- wrap lines at 'breakat'
    breakindent = true, -- wrap indent to match line start
    copyindent = true,  -- copy the previous indentation on autoindenting
    tabstop = 2,        -- tabspace = 2 spaces
    shiftwidth = 4,     -- number of space inserted for indentation
    expandtab = true,   -- convert spaces to tabs
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
    infercase = true,       -- infer cases in keyword completion
    smartcase = true,       -- smart case

    -- completion
    updatetime = 300,                                -- faster completion (4000ms default)
    timeoutlen = 300,                                -- time to wait for a mapped sequence to complete (in milliseconds)
    completeopt = { "menu", "menuone", "noselect" }, -- Options for insert mode completion

    -- appearance
    termguicolors = true,      -- set term gui colors (most terminals support this)
    background = "dark",        -- or "light" for light mode
    conceallevel = 0,          -- so that `` is visible in markdown files
    guifont = "monospace:h20", -- the font used in graphical neovim applications
    -- signcolumn = "yes",   -- always show the sign column, otherwise it would shift the text each time

    -- nvim-ufo
    fillchars = { eob = " " },                              -- disable `~` on nonexistent lines
    foldenable = true,                                      -- enable fold for nvim-ufo
    foldlevel = 99,                                         -- set high foldlevel for nvim-ufo
    foldlevelstart = 99,                                    -- start with all code unfolded
    foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
}

local global = {
    mapleader = " ",
    maplocalleader = " ",

}

for setting, value in pairs(options) do
    vim.opt[setting] = value
end

for setting, value in pairs(global) do
    vim.g[setting] = value
end

-- for scope, table in pairs(options) do
--     for setting, value in pairs(table) do
--         vim[scope][setting] = value
--     end
-- end

-- vim.opt.shortmess = "ilmnrx" -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append "c"                    -- don't give |ins-completion-menu| messages
vim.opt.isfname:append("@-@")                   -- make words with - a single word
vim.opt.iskeyword:append "-"                    -- hyphenated words recognized by searches

vim.opt.viewoptions:remove "curdir"             -- disable saving current directory with views
vim.opt.shortmess:append { s = true, I = true } -- disable search count wrap and startup messages
vim.opt.backspace:append { "nostop" }           -- don't stop backspace at insert

if vim.fn.has "nvim-0.9" == 1 then
    vim.opt.diffopt:append "linematch:60" -- enable linematch diff algorithm
end
