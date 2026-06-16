-- harpoon: pin a handful of files and jump between them instantly.
return {
  "ThePrimeagen/harpoon",
  version = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    local map = vim.keymap.set
    map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
    map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
    for i = 1, 4 do
      map("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon file " .. i })
    end
    map("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
    map("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next" })
  end,
}
