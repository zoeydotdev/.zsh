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

local windows = false
local path = os.getenv("PATH")
if string.match(string.lower(path), "system32") ~= nil then
    windows = true
end

--[[
    Windows-only configuration
]]

if windows then
    config.default_domain = 'WSL:Debian' -- Always open WezTerm to the WSL Debian installation
end

return config
