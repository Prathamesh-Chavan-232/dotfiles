-- lazydev: proper Lua LSP completion for the Neovim API while editing config.
return {
  "folke/lazydev.nvim",
  config = function()
    require("lazydev").setup({
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    })
  end,
}
