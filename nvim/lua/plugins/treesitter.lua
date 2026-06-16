-- nvim-treesitter on the `master` branch: parsers compile with the system C
-- compiler (no external `tree-sitter` CLI needed). Build runs :TSUpdate via the
-- loader's PackChanged hook.
return {
  "nvim-treesitter/nvim-treesitter",
  version = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash", "c", "css", "diff", "dockerfile", "gitignore", "go", "html",
        "javascript", "jsdoc", "json", "jsonc", "lua", "luadoc", "markdown",
        "markdown_inline", "python", "query", "rust", "scss", "toml", "tsx",
        "typescript", "vim", "vimdoc", "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
