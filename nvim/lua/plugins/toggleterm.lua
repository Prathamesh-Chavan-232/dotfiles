-- Integrated terminal.
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
    })
    -- Always target a fixed terminal id (a count) so the same buffer is reused
    -- instead of spawning a new terminal. Without a count toggleterm falls back
    -- to smart_toggle, which allocates a fresh id once all terminals are hidden.
    local function toggle_float() vim.cmd("1ToggleTerm direction=float") end
    vim.keymap.set({ "n", "t" }, [[<c-\>]], toggle_float, { desc = "Terminal (toggle)" })
    vim.keymap.set("n", "<leader>tf", toggle_float, { desc = "Terminal (float)" })
    vim.keymap.set("n", "<leader>th", "<cmd>2ToggleTerm direction=horizontal<cr>", { desc = "Terminal (horizontal)" })
    -- Pick / jump back to any open terminal.
    vim.keymap.set("n", "<leader>ts", "<cmd>TermSelect<cr>", { desc = "Select terminal" })
    -- Escape terminal mode with <Esc><Esc>.
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  end,
}
