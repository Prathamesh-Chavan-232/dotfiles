-- fzf-lua: primary fuzzy finder.
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      "default-title",
      winopts = { height = 0.85, width = 0.85, preview = { default = "bat" } },
    })

    local map = vim.keymap.set
    map("n", "<leader>ff", fzf.files, { desc = "Find files" })
    map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
    map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
    map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
    map("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
    map("n", "<leader>fh", fzf.helptags, { desc = "Help tags" })
    map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Document diagnostics" })
    map("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })
    map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
    map("n", "<leader>fc", fzf.resume, { desc = "Resume last picker" })
    map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document symbols" })
    map("n", "<leader><space>", fzf.files, { desc = "Find files" })

    map("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
    map("n", "<leader>gC", fzf.git_bcommits, { desc = "Git buffer commits" })
  end,
}
