require("config.core.keymaps")
require("config.core.lazy")
require("config.core.options")

vim.api.nvim_create_autocmd("VimLeave", {
  command = "set guicursor=a:block"
})
