-- Indent guides.
return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("ibl").setup({
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    })
  end,
}
