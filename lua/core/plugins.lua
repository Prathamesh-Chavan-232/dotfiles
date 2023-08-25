local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Plugins

  -- Git plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim', --  Adds git releated signs to the gutter, as well as utilities for managing changes

  -- Editor Feature plugins
  -- Navigation plugins
  {
    'nvim-telescope/telescope.nvim', -- Fuzzy Finder (files, lsp, etc)
    tag = '0.1.2',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  "nvim-tree/nvim-tree.lua",                               --  Nvim tree (File Explorer)
  'ThePrimeagen/harpoon',                                  --  Harpoon (Quick switcher)
  "lewis6991/impatient.nvim",                              -- Faster loading times
  'tpope/vim-sleuth',                                      --  Detect tabstop and shiftwidth automatically
  { 'akinsho/toggleterm.nvim', version = "*", opts = {} }, -- Integrated Terminals
  'mbbill/undotree',                                       -- Undotree (View branches in changes)
  { 'numToStr/Comment.nvim',   opts = {} },                -- "gcc" to comment visual regions/lines
  "JoosepAlviste/nvim-ts-context-commentstring",
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim', -- Indent guidelines
    opts = {
      char = '┊',
      show_trailing_blankline_indent = true
    },
  },
  "windwp/nvim-autopairs",        -- Add closing brackets, parenthesis & quotes automatically
  'terryma/vim-multiple-cursors', -- Multi cursors plugins


  -- Appearance
  "goolord/alpha-nvim",          -- Start screen
  "moll/vim-bbye",               --
  "ahmedkhalf/project.nvim",     --
  "norcalli/nvim-colorizer.lua",

  -- Display open buffers
  {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
  },
  "nvim-tree/nvim-web-devicons", -- file icons
  "nvim-lualine/lualine.nvim",   -- lualine (Statusline)
  -- Colorschemes
  "ellisonleao/gruvbox.nvim",
  "folke/tokyonight.nvim",
  "lunarvim/darkplus.nvim",
  {
    'navarasu/onedark.nvim', -- Theme inspired by Atom
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- Syntax highlighting plugins
  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  'nvim-treesitter/playground', -- Playground (For Syntax Highlight weights - useful for writing plugins)

  --  Autocompletion
  { 'hrsh7th/nvim-cmp' }, -- Cmp plugin
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  --  Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },

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

})
