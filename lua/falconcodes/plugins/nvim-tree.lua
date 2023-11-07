-- open file tree keymap
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>',opts)

-- open file tree plugin
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  filters = {
    dotfiles = false,
  },
})
  end,
}
