-- GitHub Copilot. Inline suggestion + panel disabled; completions surface through
-- blink.cmp (the "copilot" source in plugins/blink.lua). Node taken from $PATH.
-- Run :Copilot auth once.
return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = { ["*"] = true, gitcommit = false, gitrebase = false, help = false },
    })
  end,
}
