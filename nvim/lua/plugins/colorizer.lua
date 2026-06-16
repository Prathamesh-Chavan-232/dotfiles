-- Highlight color codes (#rrggbb, css colors, tailwind) inline.
return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      user_default_options = { tailwind = true, css = true, names = false },
    })
  end,
}
