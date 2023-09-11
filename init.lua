-- plugin manager
require "core/lazy"
-- keymaps, options, auto commands
require "core/options"
require "core/keymaps"
require "core/autocmds"
-- plugins
-- git integration
require "core/plugins/fugitive"
require "core/plugins/gitsigns"
-- editor features
require "core/plugins/telescope"  -- fuzzy finder
require "core/plugins/nvim-tree"  -- file tree
require "core/plugins/harpoon"    -- quick switcher
require "core/plugins/toggleterm" -- enter terminal without closing neovim
require "core/plugins/undotree"   -- creates undo trees
require "core/plugins/indent-blankline" -- indent guidelines
require "core/plugins/autopairs"  -- auto close brackets
require "core/plugins/alpha"      -- welcome screen
require "core/plugins/colorizer"  -- highlight colors
require "core/plugins/bufferline" -- shows open buffers like an IDE
require "core/plugins/lualine"    -- statusline
require "core/plugins/colorscheme"-- themes
require "core/plugins/treesitter" -- syntax highlighting
require "core/plugins/lsp-config" -- auto completion & lsp
