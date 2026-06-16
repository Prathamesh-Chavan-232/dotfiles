-- Visualize and navigate the undo history.
return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>uu", "<cmd>UndotreeToggle<cr>", { desc = "Undotree toggle" })
  end,
}
