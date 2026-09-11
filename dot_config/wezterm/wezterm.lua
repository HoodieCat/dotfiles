print('Wezterm config loaded')
local wezterm = require('wezterm')
local config = wezterm.config_builder()

--appearance
config.font = wezterm.font{
	family = 'Agave Nerd Font',
	weight = 'Bold',
}
config.audible_bell = "Disabled"
config.font_size = 15.0
config.window_decorations = 'RESIZE'
config.color_scheme = 'Catppuccin Mocha'
config.default_cursor_style = 'BlinkingBlock'
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true

-- shell launch
if string.find(wezterm.target_triple, 'windows') then
  config.default_prog = { 'pwsh', '-Nologo' }
end

--keybindings
local act = wezterm.action
config.leader = { key = ';', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'b', mods = 'LEADER', action = act.SplitHorizontal({ args = { 'btop' } }) },
  { key = 'D', mods = 'LEADER', action = act.ShowDebugOverlay },
  { key = 'p', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 't', mods = 'CTRL|ALT', action = act.SpawnTab('DefaultDomain') },
  { key = 't', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = false }) },
  --if directly close lase pane on last tab , collapse on Windows OS
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action_callback(function(win, pane)
      local tab = pane:tab()
      local panes = tab:panes()
      if #panes == 1 then
        win:perform_action(act.CloseCurrentTab({ confirm = true }), pane)
      else
        win:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
      end
    end),
  },
  { key = 'w', mods = 'CTRL|ALT', action = act.CloseCurrentTab({ confirm = true }) },
  { key = 'm', mods = 'LEADER', action = act.ShowTabNavigator },
  { key = 'n', mods = 'LEADER', action = act.SpawnWindow },
  { key = 's', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
  { key = ';', mods = 'LEADER', action = act.ActivatePaneDirection('Next') },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_pane',
      one_shot = false,
    }),
  },
}
config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  },
}

config.launch_menu = {
  { args = { 'btop' } },
  { label = 'pwsh', args = { 'pwsh', '-Nologo' } },
}
require('tabs')(wezterm, config)
require('appearance')(wezterm, config)
require('window')(wezterm, config)
require('mux')(wezterm, config)

return config
