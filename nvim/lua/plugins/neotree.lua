-- neo-tree file explorer.
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = { visible = false, hide_dotfiles = false, hide_gitignored = true },
      },
      window = {
        width = 32,
        mappings = {
          ["<space>"] = "none", -- keep leader free inside the tree
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer (toggle)" })
    vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal<cr>", { desc = "Explorer (reveal file)" })
  end,
}
