-- get lualine theme & new colors for theme
-- local colors = {
--     blue = "#65D1FF",
--     green = "#B1E3AD",
--     violet = "#FF61EF",
--     yellow = "#FFDA7B",
--     black = "#000000",
-- }
-- local lualine_theme = require("lualine.themes.rose-pine")
-- lualine_theme.normal.a.bg = colors.blue
-- lualine_theme.insert.a.bg = colors.green
-- lualine_theme.visual.a.bg = colors.violet
-- lualine_theme.normal.c.bg = nil
-- lualine_theme.command = {
--     a = {
--         gui = "bold",
--         bg = colors.yellow,
--         fg = colors.black, -- black
--     },
-- }

-- get lualine theme & new colors for theme
-- local colors = {
--     darkgray = "#16161d",
--     gray = "#727169",
--     innerbg = nil,
--     outerbg = nil,
--     normal = "#bd93f9",
--     insert = "#7e9cd8",
--     visual = "#ffa066",
--     replace = "#e46876",
--     command = "#e6c384",
-- }
-- local lualine_theme = {
--     inactive = {
--         a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
--         b = { fg = colors.gray, bg = colors.outerbg },
--         c = { fg = colors.gray, bg = colors.innerbg },
--     },
--     visual = {
--         a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
--         b = { fg = colors.gray, bg = colors.outerbg },
--         c = { fg = colors.gray, bg = colors.innerbg },
--     },
--     replace = {
--         a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
--         b = { fg = colors.gray, bg = colors.outerbg },
--         c = { fg = colors.gray, bg = colors.innerbg },
--     },
--     normal = {
--         a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
--         b = { fg = colors.gray, bg = colors.outerbg },
--         c = { fg = colors.gray, bg = colors.innerbg },
--     },
--     insert = {
--         a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
--         b = { fg = colors.gray, bg = colors.outerbg },
--         c = { fg = colors.gray, bg = colors.innerbg },
--     },
--     command = {
--         a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
--         b = { fg = colors.gray, bg = colors.outerbg },
--         c = { fg = colors.gray, bg = colors.innerbg },
--     },
-- }


local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
}

local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}
local filename = {
    "filename",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}
local location = {
    "location",
    padding = 0,
}
-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local config = function()
    require("lualine").setup({

        options = {
            icons_enabled = true,
            theme = 'auto',
            globalstatus = true,
            disabled_filetypes = { "alpha", "dashboard", "Outline" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { branch, diagnostics },
            lualine_b = { mode },
            lualine_c = { diff },
            lualine_x = { filename, filetype },
            lualine_y = { "location" },
            lualine_z = { progress },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
            lualine_a = { "buffers" }
        },
        extensions = { 'toggleterm', 'trouble', 'lazy', 'fugitive', 'man', 'aerial', 'quickfix' },
    })
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = config,
}
