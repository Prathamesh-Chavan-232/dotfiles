-- LazyGit integration (requires the `lazygit` binary).
return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
  end,
}
