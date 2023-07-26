-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font_with_fallback { "JetBrains Mono", "JetBrainsMono Nerd Font" }
config.font_size = 14.0
config.color_scheme = "Blue Matrix"
config.window_background_opacity = 0.92
config.hide_tab_bar_if_only_one_tab = true


config.keys = {
    {
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
}


return config
