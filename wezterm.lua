
local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'GruvboxDarkHard'

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'

config.freetype_load_target = 'HorizontalLcd'
config.font = wezterm.font 'Iosevka Term SS14'
config.font_size = 11.5
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.pane_focus_follows_mouse = true

config.keys = {
    { mods = 'ALT',       key = 'd', action = wezterm.action.SplitHorizontal {} },
    { mods = 'SHIFT|ALT', key = 'd', action = wezterm.action.SplitVertical   {} },
    { mods = 'ALT',       key = 'h', action = wezterm.action.ActivatePaneDirection 'Left' },
    { mods = 'ALT',       key = 'l', action = wezterm.action.ActivatePaneDirection 'Right' },
    { mods = 'ALT',       key = 'j', action = wezterm.action.ActivatePaneDirection 'Down' },
    { mods = 'ALT',       key = 'k', action = wezterm.action.ActivatePaneDirection 'Up' },

    { mods = 'ALT',       key = 'o', action = wezterm.action.RotatePanes 'CounterClockwise' },
    { mods = 'SHIFT|ALT', key = 'o', action = wezterm.action.RotatePanes 'Clockwise' },
    { mods = 'SHIFT|ALT',      key = 's', action = wezterm.action.PaneSelect { 
        mode='SwapWithActive',
        alphabet='1234567890',
    } },

    { mods = 'CTRL|SHIFT|ALT', key = 'h', action = wezterm.action.AdjustPaneSize { 'Left',  1 } },
    { mods = 'CTRL|SHIFT|ALT', key = 'l', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { mods = 'SHIFT|ALT',      key = 'h', action = wezterm.action.AdjustPaneSize { 'Left',  3 } },
    { mods = 'SHIFT|ALT',      key = 'l', action = wezterm.action.AdjustPaneSize { 'Right', 3 } },
    { mods = 'SHIFT|ALT',      key = 'j', action = wezterm.action.AdjustPaneSize { 'Down',  1 } },
    { mods = 'SHIFT|ALT',      key = 'k', action = wezterm.action.AdjustPaneSize { 'Up',    1 } },
    { mods = 'SHIFT|ALT',      key = 'z', action = wezterm.action.TogglePaneZoomState },

    { mods = 'ALT', key = 't', action = wezterm.action.SpawnTab 'DefaultDomain' },
    { mods = 'ALT', key = '[', action = wezterm.action.ActivateTabRelative (-1) },
    { mods = 'ALT', key = ']', action = wezterm.action.ActivateTabRelative (1) },
    { mods = 'ALT', key = '1', action = wezterm.action.ActivateTab (0) },
    { mods = 'ALT', key = '2', action = wezterm.action.ActivateTab (1) },
    { mods = 'ALT', key = '3', action = wezterm.action.ActivateTab (2) },
    { mods = 'ALT', key = '4', action = wezterm.action.ActivateTab (3) },
    { mods = 'ALT', key = '5', action = wezterm.action.ActivateTab (4) },
    { mods = 'ALT', key = '6', action = wezterm.action.ActivateTab (5) },
    { mods = 'ALT', key = '7', action = wezterm.action.ActivateTab (6) },
    { mods = 'ALT', key = '8', action = wezterm.action.ActivateTab (7) },
    { mods = 'ALT', key = '9', action = wezterm.action.ActivateTab (-1) },
}

return config

