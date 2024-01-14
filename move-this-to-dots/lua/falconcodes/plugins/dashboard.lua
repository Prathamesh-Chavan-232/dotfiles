return {

    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", "New file", "<cmd>ene <CR>"),
            dashboard.button("SPC f f", "Find file"),
            dashboard.button("SPC f o", "Recently opened files"),
            dashboard.button("SPC f r", "Resume Telescope"),
            dashboard.button("SPC f w", "Find word"),
            dashboard.button("SPC f b", "Open buffers"),
        }
        _Gopts = {
            position = "center",
            hl = "Type",
            -- wrap = "overflow";
        }

        local function footer()
            return "Programming is an art of patience not talent"
        end

        dashboard.section.footer.val = footer()

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end,
}
