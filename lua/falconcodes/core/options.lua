local global = {
    mapleader = " ",
    maplocalleader = " ",
}

local options = {

    -- UI features --
    cmdheight = 3,         -- set command line height -> 0 hides the command line unless its being used
    pumheight = 10,        -- height of the pop up menu
    laststatus = 3,        -- global statusline
    guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175", -- blinking cursor, change cursor style, "" keeps a fat cursor at all times
    showmode = true,       -- set mode visibility on command line e.g. -- INSERT --
    cursorline = true,     -- set highlight on the current line

    -- line numbers
    number = true,         -- set numbered lines
    relativenumber = true, -- set relative line numbers
    numberwidth = 4,       -- set number column {default 4}

    -- indents, tabs & spaces
    tabstop = 4,        -- 1 tabspace = ? spaces
    shiftwidth = 4,     -- number of spaces inserted for indentation
    softtabstop = 4,    -- 1 tabspace in insert mode
    expandtab = true,   -- convert spaces to tabs
    copyindent = true,  -- copy the previous indentation on autoindenting
    autoindent = true,  -- set auto indenting
    breakindent = true, -- wrap indent to match line start
    smartindent = true, -- make indenting smarter again
    linebreak = true,   -- wrap lines at 'breakat'

    -- appearance
    termguicolors = true,      -- set term gui colors (most terminals support this)
    background = "dark",       -- or "light" for light mode
    guifont = "monospace:h20", -- the font used in graphical neovim applications
    colorcolumn = '100',       -- highlight the 100th character
    signcolumn = "yes",        -- always show the sign column, otherwise it would shift the text each time
    conceallevel = 0,          -- so that `` is visible in markdown files
    fillchars = { eob = " " }, -- disable `~` on nonexistent lines

    -- Editor behaviour --
    mouse = "a",           -- set mouse usuage "" disables mouse
    history = 100,         -- number of commands to remember in a history table
    virtualedit = "block", -- allow going past end of line in visual block mode
    -- clipboard = "unnamedplus", -- make neovim use the system clipboard
    backspace = "indent,eol,start", -- makes backspace work properly

    -- searching
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = false,       -- highlight all matches on previous search pattern
    incsearch = true,       -- incremental search
    ignorecase = true,      -- ignore case in search patterns
    infercase = true,       -- infer cases in keyword completion
    smartcase = true,       -- smart case
    -- scrolling & text wrap
    scrolloff = 8,     -- number of lines to keep above and below the cursor
    sidescrolloff = 8, -- number of columns to keep at the sides of the cursor
    wrap = false,      -- set text wrap (disregrads the previous setting, best to set a keybind, wrap is very disorienting)

    -- buffers,tabs & splits
    showtabline = 2,   -- always show tabs
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window

    -- completion
    updatetime = 300,                                -- faster completion (4000ms default)
    timeoutlen = 300,                                -- time to wait for a mapped sequence to complete (in milliseconds)
    completeopt = { "menu", "noinsert", "noselect" }, -- Options for insert mode completion

    -- undo & undotree
    undofile = true,                                -- enable persistent undo
    undodir = os.getenv("HOME") .. "/.vim/undodir", -- enable undotree

    -- swap and backup
    writebackup = false, -- handle files that are edited by another program simulatenously
    backup = false,      -- set backup file
    swapfile = false,    -- set swapfile
}

-- globals
for setting, value in pairs(global) do
    vim.g[setting] = value
end

-- opts
for setting, value in pairs(options) do
    vim.opt[setting] = value
end

vim.opt.shortmess = "ilmnrx" -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append "c"                    -- don't give |ins-completion-menu| messages
vim.opt.isfname:append("@-@")                   -- make words with - a single word
vim.opt.iskeyword:append "-"                    -- hyphenated words recognized by searches

vim.opt.viewoptions:remove "curdir"             -- disable saving current directory with views
vim.opt.shortmess:append { s = true, I = true } -- disable search count wrap and startup messages
vim.opt.backspace:append { "nostop" }           -- don't stop backspace at insert

if vim.fn.has "nvim-0.9" == 1 then
    vim.opt.diffopt:append "linematch:60" -- enable linematch diff algorithm
end
