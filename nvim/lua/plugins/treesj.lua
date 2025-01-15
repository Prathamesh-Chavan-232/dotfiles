--TODO: find the working of this plugin
--TODO: find a faster plugin for the same job / make this plugin faster
return {
  "Wansmer/treesj",
  keys = { "<leader>m" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
     require("treesj").setup({})
  end,
}
