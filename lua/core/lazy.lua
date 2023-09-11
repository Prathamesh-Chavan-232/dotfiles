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
  { 'tpope/vim-fugitive'
},
  { 'tpope/vim-rhubarb' },
  { 'lewis6991/gitsigns.nvim' }, --  Adds git releated signs to the gutter, as well as utilities for managing changes

  -- Editor Feature plugins
  -- Navigation plugins
  { 'christoomey/vim-tmux-navigator' },
  {
    'nvim-telescope/telescope.nvim', -- Fuzzy Finder (files, lsp, etc)
    tag = '0.1.2',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  { "nvim-tree/nvim-tree.lua" }, --  Nvim tree (File Explorer)
  'ThePrimeagen/harpoon',        --  Harpoon (Quick switcher)

  -- Editor features
  { 'tpope/vim-sleuth' },
  { "lewis6991/impatient.nvim" },                                             -- Faster loading times
  { 'akinsho/toggleterm.nvim',                    version = "*", opts = {} }, -- Integrated Terminals
  { 'mbbill/undotree' },                                                      -- Undotree (View branches in changes)
  { 'numToStr/Comment.nvim',                      opts = {} },                -- "gcc" to comment visual regions/lines
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    'lukas-reineke/indent-blankline.nvim', -- Indent guidelines
    opts = {
      char = '┊',
      show_trailing_blankline_indent = true
    },
  },
  { 'tpope/vim-surround' },           -- surrond text with "", '', {}, etc
  { "windwp/nvim-ts-autotag" },       -- auto close html, jsx tags
  { "windwp/nvim-autopairs" },        -- Add closing brackets, parenthesis & quotes automatically
  { 'terryma/vim-multiple-cursors' }, -- Multi cursors plugins


  -- Appearance
  { "goolord/alpha-nvim" },          -- Start screen
  { "moll/vim-bbye" },               --
  { "ahmedkhalf/project.nvim" },     -- easily move through projects
  { "norcalli/nvim-colorizer.lua" }, -- highlight colors

  {
    'akinsho/bufferline.nvim', -- Display open buffers
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  { "nvim-lualine/lualine.nvim" },   -- lualine (Statusline)
  { "nvim-tree/nvim-web-devicons" }, -- file icons

  -- Colorschemes
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  { "lunarvim/darkplus.nvim" },
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
  }, { 'datsfilipe/min-theme.nvim' },


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
  { 'mattn/emmet-vim' },  -- vscode like html/css completion
  { 'hrsh7th/nvim-cmp' }, -- Cmp plugin
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  --  Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
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

})
