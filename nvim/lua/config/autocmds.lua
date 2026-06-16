-- Autocommands shared across the config.
local augroup = function(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Return to the last cursor position when reopening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Run ESLint's fix-all before writing JS/TS files, if an eslint client is
-- attached. Formatting (prettier/stylua) is handled by conform's format_on_save.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("eslint_fix"),
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.cjs", "*.vue", "*.svelte" },
  callback = function(event)
    local clients = vim.lsp.get_clients({ bufnr = event.buf, name = "eslint" })
    if #clients > 0 then
      -- nvim-lspconfig registers this buffer-local command on the eslint client.
      pcall(vim.cmd, "LspEslintFixAll")
    end
  end,
})

-- Close some utility buffers with `q`.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "qf", "man", "checkhealth", "lspinfo", "notify" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
