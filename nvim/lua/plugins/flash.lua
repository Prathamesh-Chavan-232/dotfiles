-- flash.nvim: fast in-buffer motion. `s` to jump, `S` for treesitter selection.
return {
  "folke/flash.nvim",
  config = function()
    require("flash").setup()
    vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })
    vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash treesitter" })
  end,
}
