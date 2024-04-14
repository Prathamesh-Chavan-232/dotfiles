return {
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.simple_colors = true
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "andromeda"
      vim.cmd("colorscheme sonokai")
    end,
  },
}
