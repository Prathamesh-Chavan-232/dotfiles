-- git-conflict.nvim: conflict markers + co/ct/cb/c0 to pick ours/theirs/both/none,
-- and ]x/[x to jump between conflicts.
return {
  "akinsho/git-conflict.nvim",
  config = function()
    require("git-conflict").setup({
      default_mappings = true, -- co ct cb c0
      disable_diagnostics = false,
    })
    vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next conflict" })
    vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Prev conflict" })
  end,
}
