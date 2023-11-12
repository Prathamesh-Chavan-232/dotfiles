local config = function()
	require("nvim-treesitter.configs").setup({
		build = ":TSUpdate",
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		event = {
			"BufReadPre",
			"BufNewFile",
		},
  ensure_installed = {
    "cmake",
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "xml",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "svelte",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "sql",
    "python",
    "cpp",
    "java",
    "dart",
    "ini",
    "vue",
    "solidity",
  },
		auto_install = true, -- Automatically Install missing parsers
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		incremental_selection = {
			enable = true,
            keymaps = {
                init_selection = "<C-z>",
				node_incremental = "<C-z>",
				scope_incremental = false,
				node_decremental = "<BS>",
			},
		},
	})
end

return {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    lazy = false,
    build = ':TSUpdate',
    config = config
}
