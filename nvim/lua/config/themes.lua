-- Single source of truth for selectable colorschemes.
--
-- Each entry describes one theme plugin:
--   src      = "owner/repo" for vim.pack (plugins/colorschemes.lua)
--   name     = optional install dir override (same as plugin spec `name`)
--   variants = { { "Display Name", "colorscheme-cmd" }, ... } -> themery picker
--   setup(transparent) = applies the theme's options; called before the
--                        colorscheme loads and again on transparency toggle
--                        (config/theme.lua owns the transparent flag).
return {
  {
    src = "craftzdog/solarized-osaka.nvim",
    variants = { { "Solarized Osaka", "solarized-osaka" } },
    setup = function(transparent)
      require("solarized-osaka").setup({ transparent = transparent })
    end,
  },
  {
    src = "folke/tokyonight.nvim",
    variants = {
      { "Tokyo Night", "tokyonight" },
      { "Tokyo Night (Storm)", "tokyonight-storm" },
      { "Tokyo Night (Day)", "tokyonight-day" },
    },
    setup = function(transparent)
      require("tokyonight").setup({
        transparent = transparent,
        styles = {
          sidebars = transparent and "transparent" or "dark",
          floats = transparent and "transparent" or "dark",
        },
      })
    end,
  },
  {
    src = "catppuccin/nvim",
    name = "catppuccin",
    variants = {
      { "Catppuccin Mocha", "catppuccin-mocha" },
      { "Catppuccin Macchiato", "catppuccin-macchiato" },
    },
    setup = function(transparent)
      require("catppuccin").setup({ transparent_background = transparent })
    end,
  },
  {
    src = "ellisonleao/gruvbox.nvim",
    variants = { { "Gruvbox", "gruvbox" } },
    setup = function(transparent)
      require("gruvbox").setup({ transparent_mode = transparent })
    end,
  },
  {
    src = "rose-pine/neovim",
    name = "rose-pine",
    variants = {
      { "Rose Pine", "rose-pine" },
      { "Rose Pine Moon", "rose-pine-moon" },
    },
    setup = function(transparent)
      require("rose-pine").setup({
        styles = { transparency = transparent },
      })
    end,
  },
}
