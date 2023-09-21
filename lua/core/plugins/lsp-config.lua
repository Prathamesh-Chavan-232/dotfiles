local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  -- vimscript
  'vimls',
  -- lua
  'lua_ls',
  'stylua',
  -- typescript & frameworks
  'tsserver',
  'astro',
  'svelte',
  'volar',
  'angularls',
  -- css & frameworks
  'cssls',
  'stylelint_lsp',
  'tailwindcss',
  'cssmodules_ls',
  -- emmet & html
  'emmet_ls',
  'emmet_language_server',
  'html',
  -- prisma & sql
  'prismals',
  'sqlls',
 -- low level
  'bashls',
  'cmake',
  'clangd',
  -- python
  'pylsp',
  -- docker
  'dockerls',
  'docker_compose_langauge_service',
  -- misc
  'solidity', -- blockchain
  'rust_analyzer', --rust
  'arduino_language_server', -- arduino IDE (embedded C)
  'grammarly', -- Text
  'yamlls', -- yaml configs
})

lsp.nvim_workspace()
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- Go to definition
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  -- References
  vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end, opts)
  vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
  -- Show Documentation
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  -- Search Symbols
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

  -- Goto
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

  -- Code actions
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
