-- Sticky context: shows the enclosing function/class at the top of the window.
return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({ max_lines = 3 })
    vim.keymap.set("n", "<leader>ut", "<cmd>TSContextToggle<cr>", { desc = "Toggle treesitter context" })
  end,
}
