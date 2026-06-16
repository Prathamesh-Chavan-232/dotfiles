-- Start screen / dashboard.
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", "<cmd>lua require('fzf-lua').files()<cr>"),
      dashboard.button("r", "  Recent files", "<cmd>lua require('fzf-lua').oldfiles()<cr>"),
      dashboard.button("g", "  Live grep", "<cmd>lua require('fzf-lua').live_grep()<cr>"),
      dashboard.button("e", "  File explorer", "<cmd>Neotree toggle<cr>"),
      dashboard.button("c", "  Config", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })<cr>"),
      dashboard.button("u", "  Update plugins", "<cmd>lua vim.pack.update()<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
    }
    require("alpha").setup(dashboard.opts)
  end,
}
