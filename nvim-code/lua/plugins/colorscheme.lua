return {
  "ribru17/bamboo.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local bamboo = require("bamboo")
    bamboo.setup({
      transparent = true,
    })
    bamboo.load()

    -- Highlights
    vim.cmd.hi("clear", "NormalFloat")
    vim.cmd.hi("link", "NormalFloat", "Normal")
  end,
}

