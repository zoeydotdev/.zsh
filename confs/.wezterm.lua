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

local arch = nil
if jit and jit.os then
    arch = jit.arch
end

--[[
        Windows-only configuration
]]
if arch == 'x64' then
    -- print('OS detected: Windows')
    config.default_domain = 'WSL:Debian' -- Always open WezTerm to the WSL Debian installation
end

--[[
        Mac-only configuration
]]
if arch == 'arm64' then
    -- print('OS detected: Darwin')
end

if arch == nil then
    print('Unable to recognize OS')
end

return config
