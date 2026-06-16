-- Highlight and search TODO / FIXME / HACK / NOTE comments.
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup()
    vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo" })
    vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev todo" })
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
  end,
}
