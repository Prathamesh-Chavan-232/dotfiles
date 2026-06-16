-- Formatting via conform.nvim. ESLint linting/fixing is handled by the eslint
-- LSP (plugins/lsp.lua + config/autocmds.lua); conform handles formatters.
return {
  "stevearc/conform.nvim",
  config = function()
    local prettier = { "prettierd", "prettier", stop_after_first = true }
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        css = prettier,
        scss = prettier,
        html = prettier,
        markdown = prettier,
        yaml = prettier,
        python = { "ruff_format" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1500, lsp_format = "fallback" }
      end,
    })

    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end
    end, { bang = true, desc = "Toggle autoformat (bang = buffer only)" })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      require("conform").format({ async = true, lsp_format = "fallback" })
    end, { desc = "Format buffer/selection" })
  end,
}
