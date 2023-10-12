vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    adaptive_size = true,
    side = "left",
  },
  update_cwd = true,
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = false,
  },
  diagnostics = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})
-- open file tree
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')
