-- Lightweight editing helpers from mini.nvim.
return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.pairs").setup() -- auto-close brackets/quotes
    require("mini.surround").setup() -- sa/sd/sr add/delete/replace surroundings
    require("mini.ai").setup() -- richer text objects (ci(, ca", etc.)

    -- JSX/TSX-aware commenting: mini.comment defers commentstring to
    -- ts-context-commentstring (see plugins/ts-context-commentstring.lua).
    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          local ok, tcc = pcall(require, "ts_context_commentstring.internal")
          if ok then
            return tcc.calculate_commentstring() or vim.bo.commentstring
          end
          return vim.bo.commentstring
        end,
      },
    })
  end,
}
