return {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = false,
        })
        vim.keymap.set("n", "-", ":Oil<CR>")
    end,
}
