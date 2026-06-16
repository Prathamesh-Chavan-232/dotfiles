-- Testing: neotest with jest + vitest adapters.
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-jest"),
        require("neotest-vitest"),
      },
    })
    local map = vim.keymap.set
    map("n", "<leader>tt", function() neotest.run.run() end, { desc = "Test nearest" })
    map("n", "<leader>tT", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test file" })
    map("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Test summary" })
    map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Test output" })
    map("n", "<leader>tp", function() neotest.output_panel.toggle() end, { desc = "Test output panel" })
  end,
}
