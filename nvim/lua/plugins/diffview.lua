-- diffview.nvim: side-by-side diffs + 3-way merge-conflict resolver.
return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup()
    local map = vim.keymap.set
    map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
    map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })
    map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
    map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch history" })
  end,
}
