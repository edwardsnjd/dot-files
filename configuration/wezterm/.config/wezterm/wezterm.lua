-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font('JetBrains Mono NL', { weight = 'Regular' })
config.bold_brightens_ansi_colors = true
config.color_scheme = 'Night Owl (Gogh)'
config.enable_tab_bar = false
config.freetype_load_target = "Light"
config.font_size = 15
config.line_height = 1.05
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 30,
  right = 30,
  top = 30,
  bottom = 30,
}

-- and finally, return the configuration to wezterm
return config
