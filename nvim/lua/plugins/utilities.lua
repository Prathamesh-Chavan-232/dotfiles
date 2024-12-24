return {
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("tailwind-fold").setup({
        ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
      })
    end,
  },

  {
    "laytan/tailwind-sorter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    build = "cd formatter && npm ci && npm run build",
    config = function()
      require("tailwind-sorter").setup({
        on_save_enabled = false, -- If `true`, automatically enables on save sorting.
        on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.twig", "*.hbs", "*.php", "*.heex", "*.astro" }, -- The file patterns to watch and sort.
        node_path = "node",
        trim_spaces = false, -- If `true`, trim any extra spaces after sorting.
      })
    end,
  },
}
