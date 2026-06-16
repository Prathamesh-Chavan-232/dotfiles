-- Auto-close / auto-rename HTML & JSX tags (treesitter-based).
return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
