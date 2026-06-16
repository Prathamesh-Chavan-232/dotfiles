-- Neogit: full magit-style git UI. Uses diffview for diffs.
return {
  "NeogitOrg/neogit",
  dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "ibhagwan/fzf-lua" },
  config = function()
    require("neogit").setup({ integrations = { diffview = true, fzf_lua = true } })
    vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
  end,
}
