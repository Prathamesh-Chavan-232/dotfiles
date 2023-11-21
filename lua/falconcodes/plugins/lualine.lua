-- get lualine nightfly theme
local lualine_theme = require("lualine.themes.rose-pine")

-- new colors for theme
local new_colors = {
    blue = "#65D1FF",
    green = "#B1E3AD",
    violet = "#FF61EF",
    yellow = "#FFDA7B",
    black = "#000000",
}

-- change nightlfy theme colors
-- lualine_theme.normal.a.bg = new_colors.blue
-- lualine_theme.insert.a.bg = new_colors.green
-- lualine_theme.visual.a.bg = new_colors.violet
lualine_theme.normal.c.bg = nil
lualine_theme.command = {
    a = {
        gui = "bold",
        bg = new_colors.yellow,
        fg = new_colors.black, -- black
    },
}

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
        theme = lualine_theme,
        globalstatus = true,
        -- disabled_filetypes = { "alpha", "dashboard", "Outline" },
        -- always_divide_middle = true,
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
        lualine_a = {"buffers"}
    },
    -- winbar = {
    --     lualine_a = {},
    --     lualine_b = {},
    --     lualine_c = {'filename'},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = {}
    -- },
    extensions = {'nvim-tree','toggleterm','trouble','lazy','fugitive','man','aerial','quickfix'},
    })
end

return {
   "nvim-lualine/lualine.nvim",
    lazy = false,
    config = config,
}
