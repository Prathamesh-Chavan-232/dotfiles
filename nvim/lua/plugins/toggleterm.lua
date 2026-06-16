-- Integrated terminal.
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
    })
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal (float)" })
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal (horizontal)" })
    -- Escape terminal mode with <Esc><Esc>.
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  end,
}
