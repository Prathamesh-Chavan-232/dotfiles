-- Treesitter text objects on the `main` branch.
--
-- The old `require("nvim-treesitter.configs").setup({ textobjects = ... })`
-- entry point no longer exists -- nvim-treesitter.configs was deleted in the
-- main-branch rewrite. Options now go through nvim-treesitter-textobjects'
-- own setup(), and every keymap is registered by hand.
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  version = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    -- Select: af/if, ac/ic, aa/ia (same bindings as before).
    local objects = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
    }
    for lhs, query in pairs(objects) do
      vim.keymap.set({ "x", "o" }, lhs, function()
        select.select_textobject(query, "textobjects")
      end, { desc = "Select " .. query })
    end

    -- Move: ]f/[f, ]c/[c.
    local moves = {
      { "]f", move.goto_next_start,     "@function.outer", "Next function start" },
      { "[f", move.goto_previous_start, "@function.outer", "Prev function start" },
      { "]c", move.goto_next_start,     "@class.outer",    "Next class start" },
      { "[c", move.goto_previous_start, "@class.outer",    "Prev class start" },
    }
    for _, m in ipairs(moves) do
      local lhs, fn, query, desc = m[1], m[2], m[3], m[4]
      vim.keymap.set({ "n", "x", "o" }, lhs, function()
        fn(query, "textobjects")
      end, { desc = desc })
    end
  end,
}
