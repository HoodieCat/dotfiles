return function(wezterm, config)
  -- config.window_decorations = 'RESIZE'
  config.use_fancy_tab_bar = false
  config.tab_max_width = 25
  config.hide_tab_bar_if_only_one_tab = true
  config.window_padding = {
    top = 5,
    right = 0,
    left = 5,
    bottom = 0,
  }
end
