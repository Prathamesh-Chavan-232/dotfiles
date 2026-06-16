-- Context-aware commentstring (JSX/TSX). mini.comment consumes this; autocmd
-- mode disabled since mini.comment computes the commentstring on demand.
return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  config = function()
    require("ts_context_commentstring").setup({ enable_autocmd = false })
  end,
}
