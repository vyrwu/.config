local wezterm = require("wezterm")
local act = wezterm.action
return {
  font = wezterm.font("Hack"),
  font_size = 16.0,
  color_scheme = "nordfox",
  enable_tab_bar = false,
  window_background_opacity = 0.97,
  window_decorations = "RESIZE",
  keys = {
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = act.ActivatePaneDirection("Left"),
    },
    {
      key = "l",
      mods = "CTRL|SHIFT",
      action = act.ActivatePaneDirection("Right"),
    },
    {
      key = "k",
      mods = "CTRL|SHIFT",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "j",
      mods = "CTRL|SHIFT",
      action = act.ActivatePaneDirection("Down"),
    },
  },
}
