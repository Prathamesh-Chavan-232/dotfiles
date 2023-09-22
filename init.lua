-- plugin manager
require "falconcodes/plugins-setup"
-- keymaps, options, auto commands
require "falconcodes/core/colorscheme"-- themes
require "falconcodes/core/options"
require "falconcodes/core/keymaps"
require "falconcodes/core/autocmds"
-- plugins
-- git integration
require "falconcodes/plugins/fugitive"
require "falconcodes/plugins/gitsigns"
-- faster laoding
require "falconcodes/plugins/impatient"  -- fuzzy finder
-- navigation
require "falconcodes/plugins/telescope"  -- fuzzy finder
require "falconcodes/plugins/tmux-navigation"  -- fuzzy finder
require "falconcodes/plugins/nvim-tree"  -- file tree
require "falconcodes/plugins/harpoon"    -- quick switcher
-- editor features
require "falconcodes/plugins/alpha"      -- welcome screen
require "falconcodes/plugins/undotree"   -- creates undo trees
require "falconcodes/plugins/autopairs"  -- auto close brackets
require "falconcodes/plugins/toggleterm" -- enter terminal without closing neovim
require "falconcodes/plugins/lualine"    -- statusline
require "falconcodes/plugins/bufferline" -- shows open buffers like an IDE
require "falconcodes/plugins/colorizer"  -- highlight colors
require "falconcodes/plugins/indent-blankline" -- indent guidelines
-- syntax highlighting, auto completion, LSP
require "falconcodes/plugins/treesitter" -- syntax highlighting
require "falconcodes/plugins/lsp-config" -- auto completion & lsp
