local temp = {

  -- Plugins
  -- Git plugins
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-fugitive' },

  -- Editor Feature plugins
  -- Navigation plugins
  { 'alexghergh/nvim-tmux-navigation' },
  {
    'nvim-telescope/telescope.nvim', -- Fuzzy Finder (files, lsp, etc)
    tag = '0.1.2',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  { "nvim-tree/nvim-tree.lua" }, --  Nvim tree (File Explorer)
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  'metakirby5/codi.vim', -- Interactive code runner -- python

  -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- indent lines
  -- Editor features
  { 'mbbill/undotree' },                                                      -- Undotree (View branches in changes)
  { 'numToStr/Comment.nvim',                      opts = {} },                -- "gcc" to comment visual regions/lines
  { 'tpope/vim-surround' },     -- surrond text with "", '', {}, etc

  -- Appearance
  { "goolord/alpha-nvim" },          -- Start screen
  { "norcalli/nvim-colorizer.lua" }, -- highlight colors

  {
    'akinsho/bufferline.nvim', -- Display open buffers
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  { "nvim-tree/nvim-web-devicons" }, -- file icons

  -- Colorschemes
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  {
    'navarasu/onedark.nvim', -- Theme inspired by Atom
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'dracula/vim', -- dracula colorscheme
    lazy = false,
  },
  { 'rebelot/kanagawa.nvim' },
  { 'bluz71/vim-nightfly-colors' },
  { 'rose-pine/neovim',          name = 'rose-pine' },
  {
    "catppuccin/nvim",
  },


  -- Syntax highlighting plugins
  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  { 'nvim-treesitter/playground' }, -- Playground (For Syntax Highlight weights - useful for writing plugins)

  --  Autocompletion
  { 'hrsh7th/nvim-cmp' },    -- Cmp plugin
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },    -- path completion
  { 'hrsh7th/cmp-cmdline' }, -- path completion
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  --  Snippets
  {
    "L3MON4D3/LuaSnip",                                -- snippet Engine
    dependencies = { "rafamadriz/friendly-snippets" }, -- a bunch of snippets for various languages
  },

  -- LSP & Autocompletion plugins
  -- LSP zero
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      --  LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      --  Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      --  Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },

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
