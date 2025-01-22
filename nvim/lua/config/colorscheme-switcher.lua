-- colorscheme_switcher.lua

local M = {}
local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

-- Function to get the config path
local function get_config_path()
    return vim.fn.stdpath('config') .. '/lua/colorscheme.lua'
end

-- Function to write colorscheme to config file
local function write_colorscheme(colorscheme)
    local config_file = get_config_path()
    local content = string.format("vim.cmd('colorscheme %s')", colorscheme)
    
    -- Create directory if it doesn't exist
    local config_dir = vim.fn.fnamemodify(config_file, ':h')
    vim.fn.mkdir(config_dir, 'p')
    
    -- Write the colorscheme setting to file
    local file = io.open(config_file, 'w')
    if file then
        file:write(content)
        file:close()
    end
end

-- Function to apply and save colorscheme
local function apply_colorscheme(colorscheme)
    -- Try to set the colorscheme
    local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
    if not status_ok then
        vim.notify('Error setting colorscheme: ' .. colorscheme, vim.log.levels.ERROR)
        return
    end
    
    -- If successful, save it to config
    write_colorscheme(colorscheme)
    vim.notify('Colorscheme ' .. colorscheme .. ' applied and saved', vim.log.levels.INFO)
end

-- Function to list all available colorschemes
local function get_colorschemes()
    local colorschemes = {}
    local rtp = vim.opt.runtimepath:get()
    
    for _, path in ipairs(rtp) do
        local colors_dir = path .. '/colors'
        if vim.fn.isdirectory(colors_dir) == 1 then
            local files = vim.fn.readdir(colors_dir)
            for _, file in ipairs(files) do
                local scheme = file:match('(.+)%.vim$') or file:match('(.+)%.lua$')
                if scheme then
                    table.insert(colorschemes, scheme)
                end
            end
        end
    end
    
    return colorschemes
end

-- Custom Telescope picker for colorschemes
function M.colorscheme_picker()
    local colorschemes = get_colorschemes()
    
    pickers.new({}, {
        prompt_title = 'Colorschemes',
        finder = finders.new_table({
            results = colorschemes
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                apply_colorscheme(selection[1])
            end)
            return true
        end,
        previewer = false
    }):find()
end

-- Function to use Telescope's built-in colorscheme picker with persistence
function M.telescope_builtin_picker()
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')
    
    builtin.colorscheme(themes.get_dropdown({
        enable_preview = true,
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Apply and save the selected colorscheme
                if selection and selection[1] then
                    apply_colorscheme(selection[1])
                end
            end)
            return true
        end,
    }))
end

-- Setup function
function M.setup()
    -- Create commands for both pickers
    vim.api.nvim_create_user_command('ColorSchemeSwitcher', function()
        M.colorscheme_picker()
    end, {})
    
    vim.api.nvim_create_user_command('ColorSchemeTelescopePicker', function()
        M.telescope_builtin_picker()
    end, {})
    
    -- Try to load saved colorscheme
    local config_file = get_config_path()
    if vim.fn.filereadable(config_file) == 1 then
        dofile(config_file)
    end
end

return M
