-- gitsigns: inline hunks, stage/reset, blame.
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = "Git: " .. desc })
        end
        map("]h", gs.next_hunk, "Next hunk")
        map("[h", gs.prev_hunk, "Prev hunk")
        map("<leader>hs", gs.stage_hunk, "Stage hunk")
        map("<leader>hr", gs.reset_hunk, "Reset hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("<leader>hd", gs.diffthis, "Diff this")
        map("<leader>ht", gs.toggle_current_line_blame, "Toggle line blame")
      end,
    })
  end,
}
