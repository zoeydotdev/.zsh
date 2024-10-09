local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

--[[
        Apply user configurations
]]

-- Appearance: fonts
config.font = wezterm.font 'GoMono Nerd Font Mono'
config.font_size = 15
config.line_height = 1.0
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

-- Appearance: color scheme
config.color_scheme = 'Ef-Cherie'

--[[
        Windows-only configuration
]]

config.default_domain = 'WSL:Debian' -- Always open WezTerm to the WSL Debian installation

--[[
        Mac-only configuration
]]

return config
