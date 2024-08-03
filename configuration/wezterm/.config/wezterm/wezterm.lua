-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font('JetBrains Mono NL', { weight = 'Medium' })
config.bold_brightens_ansi_colors = true
config.color_scheme = 'Night Owl (Gogh)'
config.enable_tab_bar = false
config.freetype_load_target = "Light"
config.font_size = 15
config.line_height = 1.15
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 13,
  right = 13,
  top = 16,
  bottom = 16,
}

-- and finally, return the configuration to wezterm
return config
