-- Theme
return {
  'deparr/tairiki.nvim',
  lazy = false,
  priority = 1000, -- only necessary if you use tairiki as default theme
  config = function()
    require('tairiki').setup {
      -- optional configuration here
         transparent = true
    }
    require('tairiki').load() -- only necessary to use as default theme, has same behavior as ':colorscheme tairiki'
  end,
}

-- return {
--   "daschw/leaf.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     local bamboo = require("leaf")
--     bamboo.setup({
--       contrast = "medium",
--       transparent = true,
--     })
--     bamboo.load()
--
--     -- Highlights
--     vim.cmd.hi("clear", "NormalFloat")
--     vim.cmd.hi("link", "NormalFloat", "Normal")
--   end,
-- }
