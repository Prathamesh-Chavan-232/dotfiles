-- In-buffer rendered markdown (headings, code blocks, tables, checkboxes).
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("render-markdown").setup({ completions = { lsp = { enabled = true } } })
    vim.keymap.set("n", "<leader>um", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown render" })
  end,
}
