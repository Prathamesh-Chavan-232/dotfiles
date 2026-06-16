-- Distraction-free editing: zen-mode + twilight (dims inactive code).
return {
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    config = function()
      require("zen-mode").setup({ plugins = { tmux = { enabled = true } } })
      vim.keymap.set("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
    end,
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup()
    end,
  },
}
