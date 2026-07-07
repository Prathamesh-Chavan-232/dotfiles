-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local is_mac = wezterm.target_triple:find("darwin") ~= nil
-- local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()
local gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter = gpus[0]
config.front_end = "WebGpu"

-- config.default_domain = 'WSL:Ubuntu'
config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("JetBrains Mono Regular")
-- config.font = wezterm.font("FiraCode Nerd Font Mono")
-- config.font = wezterm.font("Monocraft Nerd Font")
-- config.font = wezterm.font("Iosevka Custom")
-- config.font = wezterm.font("Menlo Regular")
-- config.font = wezterm.font("Hasklig")
-- config.font = wezterm.font("Monoid Retina")
-- config.font = wezterm.font("InputMonoNarrow")
-- config.font = wezterm.font("mononoki Regular")
-- config.font = wezterm.font("Iosevka")
-- config.font = wezterm.font("M+ 1m")
-- config.font = wezterm.font("Hack Regular")

config.cell_width = 0.9
config.window_background_opacity = 0.85
config.prefer_egl = true
config.font_size = 16.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 32

-- config.inactive_pane_hsb = {
-- 	saturation = 0.0,
-- 	brightness = 1.0,
-- }

-- This is where you actually apply your config choices
--

-- Theme list — cycle through with Ctrl+Shift+Alt+E / Ctrl+Shift+Alt+R
local themes = {
	"Cloud (terminal.sexy)",
	"Catppuccin Mocha",
	"Tokyo Night",
	"Kanagawa (Gogh)",
	"Gruvbox dark, medium (base16)",
	"Everforest Dark Hard (Gogh)",
	"Solarized Dark (Gogh)",
	"rose-pine",
	"Dracula",
	"Nord (Gogh)",
	"Zenburn",
}

-- Font list — cycle through with Ctrl+Shift+Alt+F / Ctrl+Shift+Alt+G
local fonts = {
	"JetBrains Mono Regular",
	"FiraCode Nerd Font Mono",
	"Monocraft Nerd Font",
	"Hack Regular",
	"mononoki Regular",
	"Iosevka",
}

local function current_theme_index(overrides)
	local current = overrides.color_scheme or config.color_scheme
	for i, name in ipairs(themes) do
		if name == current then
			return i
		end
	end
	return 1
end

local function current_font_index(overrides)
	local current_font = overrides._font_name or fonts[1]
	for i, name in ipairs(fonts) do
		if name == current_font then
			return i
		end
	end
	return 1
end

wezterm.on("cycle-theme-next", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local idx = current_theme_index(overrides) % #themes + 1
	overrides.color_scheme = themes[idx]
	window:set_config_overrides(overrides)
	window:toast_notification("wezterm", "Theme: " .. themes[idx], nil, 2000)
end)

wezterm.on("cycle-theme-prev", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local idx = current_theme_index(overrides)
	idx = idx - 1
	if idx < 1 then
		idx = #themes
	end
	overrides.color_scheme = themes[idx]
	window:set_config_overrides(overrides)
	window:toast_notification("wezterm", "Theme: " .. themes[idx], nil, 2000)
end)

wezterm.on("cycle-font-next", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local idx = current_font_index(overrides) % #fonts + 1
	overrides.font = wezterm.font(fonts[idx])
	overrides._font_name = fonts[idx]
	window:set_config_overrides(overrides)
	window:toast_notification("wezterm", "Font: " .. fonts[idx], nil, 2000)
end)

wezterm.on("cycle-font-prev", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local idx = current_font_index(overrides)
	idx = idx - 1
	if idx < 1 then
		idx = #fonts
	end
	overrides.font = wezterm.font(fonts[idx])
	overrides._font_name = fonts[idx]
	window:set_config_overrides(overrides)
	window:toast_notification("wezterm", "Font: " .. fonts[idx], nil, 2000)
end)

-- keymaps
config.keys = {
	-- Theme cycling
	{ key = "E", mods = "CTRL|SHIFT|ALT", action = wezterm.action.EmitEvent("cycle-theme-next") },
	{ key = "R", mods = "CTRL|SHIFT|ALT", action = wezterm.action.EmitEvent("cycle-theme-prev") },
	-- Font cycling
	{ key = "F", mods = "CTRL|SHIFT|ALT", action = wezterm.action.EmitEvent("cycle-font-next") },
	{ key = "G", mods = "CTRL|SHIFT|ALT", action = wezterm.action.EmitEvent("cycle-font-prev") },
	-- Pane
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{ key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	-- Opacity toggle
	{
		key = "O",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.85
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
	-- Tab management
	{ key = "t", mods = "ALT|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "ALT|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "h", mods = "ALT|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "ALT|SHIFT", action = act.ActivateTabRelative(1) },
	-- Jump to tab by number
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(-1) },
}

-- macOS: translate Cmd+<key> into the Ctrl byte nvim already maps, so
-- "app-style" shortcuts use Cmd on Mac while the nvim config stays on Ctrl
-- (and on Windows Ctrl reaches nvim directly, so no WezTerm change is needed).
-- Vim's own Ctrl motions are unaffected.
if is_mac then
	local cmd_to_ctrl = { "s" } -- add more letters here as needed
	for _, k in ipairs(cmd_to_ctrl) do
		table.insert(config.keys, {
			key = k,
			mods = "CMD",
			action = act.SendKey({ key = k, mods = "CTRL" }),
		})
	end
end

-- For example, changing the color scheme:
config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	-- background = '#3b224c',
	-- background = "#181616", -- vague.nvim bg
	-- background = "#080808", -- almost black
	background = "#0c0b0f", -- dark purple
	-- background = "#020202", -- dark purple
	-- background = "#17151c", -- brighter purple
	-- background = "#16141a",
	-- background = "#0e0e12", -- bright washed lavendar
	-- background = 'rgba(59, 34, 76, 100%)',
	cursor_border = "#bea3c7",
	-- cursor_fg = "#281733",
	cursor_bg = "#bea3c7",
	-- selection_fg = '#281733',

	tab_bar = {
		background = "#0c0b0f",
		-- background = "rgba(0, 0, 0, 0%)",
		active_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#bea3c7",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			-- bg_color = "rgba(59, 34, 76, 50%)",
			bg_color = "#0c0b0f",
			fg_color = "white",
		},
	},
}

config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "#0c0b0f",
	-- active_titlebar_bg = "#181616",
}

-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
-- config.window_decorations = "NONE | RESIZE"
-- config.default_prog = { "powershell.exe", "-NoLogo" }
config.initial_cols = 80
-- config.window_background_image = "C:/dev/misc/berk.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- }

-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	-- window:gui_window():maximize()
-- 	-- window:gui_window():set_position(0, 0)
-- end)

-- and finally, return the configuration to wezterm
return config
