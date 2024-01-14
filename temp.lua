local temp = {

    -- Plugins
    -- Git plugins
    { 'tpope/vim-rhubarb' },

    -- Editor Feature plugins
    -- Navigation plugins
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    'metakirby5/codi.vim', -- Interactive code runner -- python

    -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- indent lines
    -- Editor features
    { 'mbbill/undotree' },    -- Undotree (View branches in changes)
    { 'tpope/vim-surround' }, -- surrond text with "", '', {}, etc

    -- Appearance
    { "norcalli/nvim-colorizer.lua" }, -- highlight colors
    {
        'akinsho/bufferline.nvim',     -- Display open buffers
        dependencies = 'nvim-tree/nvim-web-devicons'
    },

    -- Colorschemes


    -- Syntax highlighting plugins
    { 'nvim-treesitter/playground' }, -- Playground (For Syntax Highlight weights - useful for writing plugins)

    -- {
    --   "jackMort/ChatGPT.nvim",
    --   event = "VeryLazy",
    --   config = function()
    --     require("chatgpt").setup()
    --   end,
    --   dependencies = {
    --     "MunifTanjim/nui.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "nvim-telescope/telescope.nvim"
    --   }

}
