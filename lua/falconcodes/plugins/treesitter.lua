local config = function()
    require("nvim-treesitter.configs").setup({
        auto_install = true, -- Automatically Install missing parsers
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
        indent = {
            enable = true,
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,
        },
        autotag = {
            enable = true,
        },
        autopairs = {
            enable = true,
        },
        rainbow = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-x>",
                node_incremental = "<C-x>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
    })
end

return {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "windwp/nvim-ts-autotag",
        'nvim-treesitter/nvim-treesitter-textobjects',
        "hiphish/rainbow-delimiters.nvim",
        "windwp/nvim-autopairs",
    },

    lazy = false,
    build = ':TSUpdate',
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = config
}
