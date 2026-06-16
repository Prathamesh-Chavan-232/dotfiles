-- dropbar.nvim: IDE-style breadcrumbs in the winbar (uses native 0.10+ APIs).
return {
  "Bekaboo/dropbar.nvim",
  config = function()
    require("dropbar").setup()
    vim.keymap.set("n", "<leader>;", function() require("dropbar.api").pick() end, { desc = "Pick breadcrumb" })
  end,
}
