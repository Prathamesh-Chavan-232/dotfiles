-- trouble.nvim: pretty list for diagnostics, references, quickfix, symbols.
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup()
    local map = vim.keymap.set
    map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
    map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
    map("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
    map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix (Trouble)" })
    map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list (Trouble)" })
  end,
}
