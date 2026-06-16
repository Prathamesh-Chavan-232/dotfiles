-- Project-wide search & replace UI.
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("spectre").setup()
    vim.keymap.set("n", "<leader>sr", function() require("spectre").open() end, { desc = "Search & replace (project)" })
    vim.keymap.set("v", "<leader>sr", function() require("spectre").open_visual() end, { desc = "Search & replace (selection)" })
  end,
}
