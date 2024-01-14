require("falconcodes.core.options")
require("falconcodes.core.keymaps")
require("falconcodes.core.autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
opts = {
    defaults = {
        -- lazy = true, -- should plugins be lazy-loaded?
    },

    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
    },
    performance = {
        rtp = {
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    -- importing directories
    spec = {
        { import = "falconcodes.plugins" },
        { import = "falconcodes.plugins.lsp" },
        { import = "falconcodes.plugins.colorschemes" },
    },

    -- ui config
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8,
        },
    },


}

require("lazy").setup(opts)
require("falconcodes.core.colorscheme")
