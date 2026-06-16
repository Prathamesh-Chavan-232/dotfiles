-- themery.nvim: the :Themery picker UI (live preview). Persistence + startup
-- application is owned by config/theme.lua (a ColorScheme autocmd writes the
-- choice to a state file outside the dotfiles), so themery is just the menu.
return {
  "zaldih/themery.nvim",
  config = function()
    require("themery").setup({
      themes = {
        { name = "Solarized Osaka", colorscheme = "solarized-osaka" },
        { name = "Tokyo Night", colorscheme = "tokyonight" },
        { name = "Tokyo Night (Storm)", colorscheme = "tokyonight-storm" },
        { name = "Tokyo Night (Day)", colorscheme = "tokyonight-day" },
        { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
        { name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
        { name = "Gruvbox", colorscheme = "gruvbox" },
        { name = "Rose Pine", colorscheme = "rose-pine" },
        { name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
      },
      livePreview = true,
    })

    vim.keymap.set("n", "<leader>uc", "<cmd>Themery<cr>", { desc = "Pick colorscheme" })
  end,
}
