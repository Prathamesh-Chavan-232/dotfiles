-- Colorscheme loading with cross-session persistence.
--
-- The active theme name and the transparency flag are stored in state files
-- (outside the config repo), so switching themes never edits a tracked file.
-- A ColorScheme autocmd writes the file on every theme change, so the :Themery
-- picker (and even a manual `:colorscheme foo`) persists across sessions.
-- Theme options come from config/themes.lua: each entry's setup(transparent)
-- runs before the colorscheme is applied, and again when transparency is
-- toggled (<leader>uT), re-applying the current theme.

local M = {}

local DEFAULT = "solarized-osaka"
local state_file = vim.fn.stdpath("state") .. "/colorscheme"
local transparency_file = vim.fn.stdpath("state") .. "/colorscheme-transparent"

local function read_file(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local line = vim.trim(f:read("*l") or "")
  f:close()
  return line ~= "" and line or nil
end

local function write_file(path, content)
  local f = io.open(path, "w")
  if f then
    f:write(content)
    f:close()
  end
end

M.transparent = true

-- Run every theme's setup() with the current transparency flag.
local function apply_theme_options()
  for _, theme in ipairs(require("config.themes")) do
    pcall(theme.setup, M.transparent)
  end
end

function M.toggle_transparency()
  M.transparent = not M.transparent
  write_file(transparency_file, M.transparent and "1" or "0")
  apply_theme_options()
  -- Re-apply the active colorscheme so the new option set takes effect.
  local current = vim.g.colors_name or DEFAULT
  pcall(vim.cmd.colorscheme, current)
  vim.notify("Transparency " .. (M.transparent and "on" or "off"))
end

function M.setup()
  M.transparent = read_file(transparency_file) ~= "0"
  apply_theme_options()

  -- Persist any colorscheme change automatically.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("config_theme_persist", { clear = true }),
    callback = function(args)
      if args.match and args.match ~= "" then
        write_file(state_file, args.match)
      end
    end,
  })

  vim.keymap.set("n", "<leader>uT", M.toggle_transparency, { desc = "Toggle transparency" })

  local saved = read_file(state_file) or DEFAULT
  if not pcall(vim.cmd.colorscheme, saved) then
    pcall(vim.cmd.colorscheme, DEFAULT)
  end
end

return M
