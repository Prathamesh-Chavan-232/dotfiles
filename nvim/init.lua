-- Clean Neovim config built on vim.pack (Neovim's built-in package manager).
-- Requires Neovim 0.12+ (that is where vim.pack lives).

if vim.fn.has("nvim-0.12") == 0 or vim.pack == nil then
  vim.schedule(function()
    vim.notify(
      "This config requires Neovim 0.12+ (vim.pack).\nUpgrade with:  brew upgrade neovim",
      vim.log.levels.ERROR,
      { title = "nvim config" }
    )
  end)
  return
end

if vim.loader then
  vim.loader.enable()
end

-- Leader must be set before any plugin or keymap is registered.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Install + load all plugins, then run their per-plugin setup modules.
require("config.pack")

-- Load the persisted colorscheme (runs after colorscheme plugins are added).
require("config.theme").setup()
