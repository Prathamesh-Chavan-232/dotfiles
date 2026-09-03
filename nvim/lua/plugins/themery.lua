-- themery.nvim: the :Themery picker UI (live preview). The theme list comes
-- from config/themes.lua; persistence + startup application is owned by
-- config/theme.lua (a ColorScheme autocmd writes the choice to a state file
-- outside the dotfiles), so themery is just the menu.
return {
  "zaldih/themery.nvim",
  config = function()
    local themes = {}
    for _, theme in ipairs(require("config.themes")) do
      for _, variant in ipairs(theme.variants) do
        themes[#themes + 1] = { name = variant[1], colorscheme = variant[2] }
      end
    end

    require("themery").setup({
      themes = themes,
      livePreview = true,
    })

    vim.keymap.set("n", "<leader>uc", "<cmd>Themery<cr>", { desc = "Pick colorscheme" })
  end,
}
