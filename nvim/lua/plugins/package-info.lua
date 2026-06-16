-- Show npm package versions inline in package.json + update helpers.
return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("package-info").setup()
    local pi = require("package-info")
    vim.keymap.set("n", "<leader>ns", pi.show, { desc = "Package: show versions" })
    vim.keymap.set("n", "<leader>nu", pi.update, { desc = "Package: update" })
    vim.keymap.set("n", "<leader>np", pi.change_version, { desc = "Package: change version" })
  end,
}
