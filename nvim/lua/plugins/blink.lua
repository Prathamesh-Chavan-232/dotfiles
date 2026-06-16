-- blink.cmp completion. Fixes the old "weird accept": nothing is preselected or
-- auto-inserted; <CR>/<Tab> only accept an item you explicitly moved onto.
-- priority 90 so it configures before lsp.lua (which reads its capabilities).
return {
  "saghen/blink.cmp",
  version = vim.version.range("1"),
  dependencies = { "rafamadriz/friendly-snippets", "giuxtaposition/blink-cmp-copilot" },
  priority = 90,
  config = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "default", -- <C-y> accept, <C-n>/<C-p> navigate, <C-e> hide
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { border = "rounded" },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
        ghost_text = { enabled = false },
      },
      signature = { enabled = true, window = { border = "rounded" } },
      appearance = { nerd_font_variant = "mono" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = { name = "copilot", module = "blink-cmp-copilot", score_offset = 100, async = true },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    })
  end,
}
