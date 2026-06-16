-- which-key: shows pending keybindings + group labels.
return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.setup({ preset = "helix" })
    wk.add({
      { "<leader>a", group = "ai" },
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "git hunk" },
      { "<leader>r", group = "rename" },
      { "<leader>s", group = "split/search" },
      { "<leader>t", group = "test/toggle" },
      { "<leader>u", group = "ui / toggles" },
      { "<leader>x", group = "diagnostics" },
    })
  end,
}
