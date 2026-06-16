-- Buffer tabs.
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "neo-tree", text = "Explorer", separator = true } },
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    })
  end,
}
