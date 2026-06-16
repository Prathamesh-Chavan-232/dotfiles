-- Claude Code in Neovim (implements the same MCP protocol as the VSCode ext).
-- Requires the CLI: npm i -g @anthropic-ai/claude-code. Launch with :ClaudeCode.
return {
  "coder/claudecode.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("claudecode").setup({
      terminal = { provider = "native" }, -- avoid the optional snacks.nvim dep
    })
    local map = vim.keymap.set
    map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude Code (toggle)" })
    map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Claude Code (focus)" })
    map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Claude Code: send selection" })
    map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Claude Code: add buffer" })
  end,
}
