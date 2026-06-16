-- LSP via Neovim's native vim.lsp.config/enable API (0.11+), mason for installs,
-- nvim-lspconfig for default server configs. priority 80 (after blink.cmp).
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim",
  },
  priority = 80,
  config = function()
    require("mason").setup({ ui = { border = "rounded" } })

    -- blink.cmp capabilities for every server.
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          completion = { callSnippet = "Replace" },
          diagnostics = { globals = { "vim" } },
          hint = { enable = true },
        },
      },
    })

    vim.lsp.config("vtsls", {
      settings = {
        typescript = {
          inlayHints = {
            parameterNames = { enabled = "literals" },
            variableTypes = { enabled = false },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
          },
        },
      },
    })

    -- JSON / YAML schemas from SchemaStore.
    vim.lsp.config("jsonls", {
      settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
    })
    vim.lsp.config("yamlls", {
      settings = { yaml = { schemaStore = { enable = false, url = "" }, schemas = require("schemastore").yaml.schemas() } },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "vtsls",
        "eslint",
        "lua_ls",
        "html",
        "cssls",
        "tailwindcss",
        "jsonls",
        "yamlls",
        "emmet_language_server",
      },
      automatic_enable = true,
    })

    vim.diagnostic.config({
      virtual_text = { spacing = 2, source = "if_many" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded", source = true },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
      callback = function(event)
        local buf = event.buf
        local fzf = require("fzf-lua")
        local function nmap(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
        end

        nmap("gd", fzf.lsp_definitions, "Goto definition")
        nmap("gD", vim.lsp.buf.declaration, "Goto declaration")
        nmap("gr", fzf.lsp_references, "References")
        nmap("gi", fzf.lsp_implementations, "Goto implementation")
        nmap("gy", fzf.lsp_typedefs, "Goto type definition")
        nmap("K", vim.lsp.buf.hover, "Hover")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", fzf.lsp_code_actions, "Code action")
        nmap("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
        nmap("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        nmap("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/inlayHint") then
          nmap("<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
          end, "Toggle inlay hints")
        end
      end,
    })
  end,
}
