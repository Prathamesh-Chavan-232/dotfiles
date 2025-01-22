local wezterm = require('wezterm')
local act = wezterm.action

-- Color schemes
local color_schemes = {
  ['Bamboo'] = {
    foreground = '#f1e9d2',
    background = '#252623',
    cursor_bg = '#f1e9d2',
    cursor_fg = '#252623',
    cursor_border = '#f1e9d2',
    selection_fg = '#252623',
    selection_bg = '#f1e9d2',
    ansi = {
      '#1c1e1b',  -- black
      '#e75a7c',  -- red
      '#8fb573',  -- green
      '#dbb651',  -- yellow
      '#57a5e5',  -- blue
      '#aaaaff',  -- magenta
      '#70c2be',  -- cyan
      '#f1e9d2',  -- white
    },
    brights = {
      '#5b5e5a',  -- bright black
      '#e75a7c',  -- bright red
      '#8fb573',  -- bright green
      '#dbb651',  -- bright yellow
      '#57a5e5',  -- bright blue
      '#aaaaff',  -- bright magenta
      '#70c2be',  -- bright cyan
      '#fff8f0',  -- bright white
    },
  },
  ['Rose Pine Moon'] = {
    foreground = '#e0def4',
    background = '#232136',
    cursor_bg = '#56526e',
    cursor_fg = '#e0def4',
    cursor_border = '#56526e',
    selection_fg = '#e0def4',
    selection_bg = '#44415a',
    ansi = {
      '#393552',  -- black
      '#eb6f92',  -- red
      '#3e8fb0',  -- green
      '#f6c177',  -- yellow
      '#9ccfd8',  -- blue
      '#c4a7e7',  -- magenta
      '#ea9a97',  -- cyan
      '#e0def4',  -- white
    },
    brights = {
      '#6e6a86',  -- bright black
      '#eb6f92',  -- bright red
      '#3e8fb0',  -- bright green
      '#f6c177',  -- bright yellow
      '#9ccfd8',  -- bright blue
      '#c4a7e7',  -- bright magenta
      '#ea9a97',  -- bright cyan
      '#e0def4',  -- bright white
    },
  },
}

-- Available fonts configuration
local fonts = {
  {
    family = 'JetBrainsMono Nerd Font',
    weight = 'Regular',
    italic = false,
  },
  {
    family = 'Fira Code',
    weight = 'Regular',
    italic = false,
  },
  {
    family = 'Hack Nerd Font',
    weight = 'Regular',
    italic = false,
  },
}

-- Initialize state
local state = {
  current_theme_idx = 1,
  current_font_idx = 1,
}

local function select_theme(window, pane)
  -- Get sorted list of theme names
  local theme_names = {}
  for name, _ in pairs(color_schemes) do
    table.insert(theme_names, name)
  end
  table.sort(theme_names)
  
  -- Create choices for QuickSelect
  local choices = {}
  for _, name in ipairs(theme_names) do
    table.insert(choices, { label = name })
  end
  
  -- Show QuickSelect menu
  window:perform_action(
    act.InputSelector {
      title = 'Select Theme',
      choices = choices,
      action = wezterm.action_callback(function(window, pane, id, label)
        if not label then
          return  -- User cancelled
        end
        
        -- Apply the selected theme
        window:set_config_overrides({
          colors = color_schemes[label]
        })
        
        window:toast_notification('WezTerm', 'Theme: ' .. label, nil)
      end),
    },
    pane
  )
end

-- Helper function to cycle through themes
local function cycle_theme(window)
  local theme_names = {}
  for name, _ in pairs(color_schemes) do
    table.insert(theme_names, name)
  end
  table.sort(theme_names)
  
  state.current_theme_idx = (state.current_theme_idx % #theme_names) + 1
  local new_theme = theme_names[state.current_theme_idx]
  
  window:set_config_overrides({
    colors = color_schemes[new_theme]
  })
  
  window:toast_notification('WezTerm', 'Theme: ' .. new_theme, nil)
end

-- Helper function to cycle through fonts
local function cycle_font(window)
  state.current_font_idx = (state.current_font_idx % #fonts) + 1
  local new_font = fonts[state.current_font_idx]
  
  window:set_config_overrides({
    font = wezterm.font(new_font.family, {weight = new_font.weight, italic = new_font.italic}),
  })
  
  window:toast_notification('WezTerm', 'Font: ' .. new_font.family, nil)
end

-- Main configuration
local config = {
  -- Window configuration
  window_background_opacity = 0.85,
  enable_wayland = true,
  win32_system_backdrop = 'Acrylic',
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  
  -- Terminal configuration
  term = 'xterm-256color',
  
  -- Default font configuration
  font_size = 14,
  font = wezterm.font(fonts[1].family, {weight = fonts[1].weight, italic = fonts[1].italic}),
  
  -- Default color scheme
  colors = color_schemes['Bamboo'],
  
  -- Key bindings
   keys = {
      -- Theme switcher (Alt + T)
      {
         key = 'c',
         mods = 'ALT',
         action = wezterm.action_callback(function(window, pane)
            cycle_theme(window)
         end),
      },
      {
         key = 't',
         mods = 'ALT',
         action = wezterm.action_callback(function(window, pane)
            select_theme(window, pane)
         end),
      },
      -- Font switcher (Alt + F)
      {
         key = 'f',
         mods = 'ALT',
         action = wezterm.action_callback(function(window, pane)
            cycle_font(window)
         end),
      },
      -- Preserve your Command + K binding
      {
         key = 'k',
         mods = 'CMD',
         action = act.SendString('t'),
      },
   },
}

return config
