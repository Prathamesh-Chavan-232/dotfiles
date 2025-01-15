-- Following either your mouse or your cursor, 
-- this plugin provides a custom floating (popup) window that displays any diagnostic 
-- (Error, Warning, Hint) returned by the Diagnostic API, along with lsp information returned by the LSP API.

return {
  "soulis-1256/eagle.nvim",
  config = function()
    require("eagle").setup({})
  end,
}
