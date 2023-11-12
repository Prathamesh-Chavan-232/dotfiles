-- open file tree keymap
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', opts)

local config = function()
    require("nvim-tree").setup({
    view = {
        adaptive_size = true,
        side = "left",
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
        filters = {
        dotfiles = false,
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

})
end

-- open file tree plugin
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = config
}
