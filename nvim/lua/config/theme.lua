-- Colorscheme loading with cross-session persistence.
--
-- The active theme name is stored in a state file (outside the config repo), so
-- switching themes never edits a tracked file. A ColorScheme autocmd writes the
-- file on every theme change, so the :Themery picker (and even a manual
-- `:colorscheme foo`) persists across sessions. This module is the authoritative
-- persistence layer; themery.nvim just provides the picker UI.

local M = {}

local DEFAULT = "solarized-osaka"
local state_file = vim.fn.stdpath("state") .. "/colorscheme"

local function read_saved()
  local f = io.open(state_file, "r")
  if not f then
    return nil
  end
  local name = vim.trim(f:read("*l") or "")
  f:close()
  return name ~= "" and name or nil
end

local function write_saved(name)
  local f = io.open(state_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

function M.setup()
  -- Themes that need options set before they are applied.
  pcall(function()
    require("solarized-osaka").setup({ transparent = true })
  end)

  -- Persist any colorscheme change automatically.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("config_theme_persist", { clear = true }),
    callback = function(args)
      if args.match and args.match ~= "" then
        write_saved(args.match)
      end
    end,
  })

  local saved = read_saved() or DEFAULT
  if not pcall(vim.cmd.colorscheme, saved) then
    pcall(vim.cmd.colorscheme, DEFAULT)
  end
end

return M
