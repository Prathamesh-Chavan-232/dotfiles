-- plugin manager
require "falconcodes/plugins-setup"    -- lazy plugin manager & plugins
-- keymaps, options, auto commands
require "falconcodes/core/colorscheme" -- themes
require "falconcodes/core/options"     -- settings
require "falconcodes/core/keymaps"     -- keyboard shortcuts
require "falconcodes/core/autocmds"    -- auto run stuff
-- plugins
-- git integration
require "falconcodes/plugins/fugitive"         -- git integration
require "falconcodes/plugins/gitsigns"         -- git gutter
-- navigation
require "falconcodes/plugins/telescope"        -- fuzzy finder
require "falconcodes/plugins/tmux-navigation"  -- fuzzy finder
require "falconcodes/plugins/nvim-tree"        -- file tree
require "falconcodes/plugins/oil"              -- advanced file tree editing

-- editor features
require "falconcodes/plugins/alpha"            -- welcome screen
require "falconcodes/plugins/undotree"         -- creates undo trees
require "falconcodes/plugins/autopairs"        -- auto close brackets
require "falconcodes/plugins/toggleterm"       -- enter terminal without closing neovim
require "falconcodes/plugins/lualine"          -- statusline
require "falconcodes/plugins/bufferline"       -- shows open buffers like an IDE
require "falconcodes/plugins/colorizer"        -- highlight colors
require "falconcodes/plugins/indent-blankline" -- indent guidelines
-- syntax highlighting, auto completion, LSP
require "falconcodes/plugins/treesitter"       -- syntax highlighting
require "falconcodes/plugins/lsp-config"       -- auto completion & lsp
