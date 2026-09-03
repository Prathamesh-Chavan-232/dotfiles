-- nvim-treesitter on the `main` branch.
--
-- `master` is frozen and BROKEN on Neovim 0.12: its query directives in
-- lua/nvim-treesitter/query_predicates.lua still treat match[capture_id] as a
-- single TSNode, but 0.12 passes a list. That raises
--   "attempt to call method 'range' (a nil value)"
-- from vim.treesitter.get_node_text during injection parsing (markdown fenced
-- code blocks hit it first). See nvim-treesitter#8618 / #8636.
--
-- The `main` branch ONLY installs/updates parsers. Highlight, indent and fold
-- are Neovim features that we turn on ourselves in a FileType autocmd.
--
-- priority 100: runs before textobjects (50) and anything else that needs
-- parsers on disk.
return {
  "nvim-treesitter/nvim-treesitter",
  version = "main",
  build = ":TSUpdate",
  priority = 100,
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      -- Parsers + queries land in stdpath("data")/site by default, i.e.
      -- ~/.local/share/nvim/site/parser -- NOT inside the plugin directory
      -- like master used to do.
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Parsers to have available up front. Neovim already bundles c, lua,
    -- markdown, markdown_inline, query, vim and vimdoc; listing them is
    -- harmless but redundant, so they are omitted here.
    local ensure = {
      "bash", "css", "diff", "dockerfile", "gitignore", "go", "html",
      "javascript", "jsdoc", "json", "luadoc", "python", "rust",
      "scss", "toml", "tsx", "typescript", "yaml",
    }

    -- Install runs asynchronously and skips parsers that are already present.
    pcall(ts.install, ensure, { summary = false })

    local group = vim.api.nvim_create_augroup("config_treesitter", { clear = true })

    local function enable(buf)
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end
      -- vim.treesitter.start() errors when no parser exists for the buffer's
      -- filetype, so pcall is the availability check.
      if not pcall(vim.treesitter.start, buf) then
        return false
      end
      -- Treesitter indentation is still marked experimental upstream; drop
      -- this line if it misbehaves for a language.
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      return true
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(ev)
        if enable(ev.buf) then
          return
        end

        -- Equivalent of the old `auto_install = true`: fetch the parser the
        -- first time a filetype is opened, then turn highlighting on.
        -- get_lang() falls back to the filetype itself when no parser is
        -- registered, so plugin scratch filetypes (notify, noice, ...) land
        -- here too; skip anything nvim-treesitter doesn't actually ship,
        -- otherwise install() warns "Skipping unknown language <ft>".
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang or not vim.tbl_contains(ts.get_available(), lang) then
          return
        end

        local ok, task = pcall(ts.install, { lang }, { summary = false })
        if not ok or not task then
          return
        end

        pcall(function()
          task:wait(30000)
        end)
        vim.schedule(function()
          enable(ev.buf)
        end)
      end,
    })
  end,
}
