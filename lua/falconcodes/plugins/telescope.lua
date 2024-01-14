local keymap = vim.keymap
local opts = {}

local config = function()
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },

            planets = {
                show_pluto = true,
            },

            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
                previewer = false,
                hidden = true,
            },
            live_grep = {
                theme = "dropdown",
                previewer = false,
            },
            buffers = {
                theme = "dropdown",
                previewer = false,
            },
        },
    })
end

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = config,
    keys = {
        keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", opts),
        keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts),
        -- fuzy find files
        keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts),
        keymap.set("n", "<C-p>", ":Telescope find_files<CR>", opts),
        keymap.set("n", "<leader>fo", ":Telescope find_files<CR>", opts),
        -- navigate buffers
        keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts),
        -- search grep string
        keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", opts),
        -- search themes
        keymap.set("n", "<leader>fc", ":Telescope colorscheme<CR>", opts),
        -- Treesitter
        keymap.set("n", "<leader>fv", ":Telescope treesitter<CR>", opts),
        -- fuzy find git files
        keymap.set("n", "<leader>fgf", ":Telescope git_files<CR>", opts),
        keymap.set("n", "<leader>fgc", ":Telescope git_commits<CR>", opts),
        keymap.set("n", "<leader>fgb", ":Telescope git_branches<CR>", opts),
        keymap.set("n", "<leader>fgs", ":Telescope git_stash<CR>", opts),
    },
}
