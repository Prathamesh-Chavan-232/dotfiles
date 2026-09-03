-- Selectable colorschemes, generated from config/themes.lua (the single source
-- of truth). Theme options are applied by config/theme.lua, which calls each
-- entry's setup() with the persisted transparency flag before the colorscheme
-- loads.
local specs = {}
for _, theme in ipairs(require("config.themes")) do
  specs[#specs + 1] = { theme.src, name = theme.name }
end
return specs
