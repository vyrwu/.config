local wezterm = require("wezterm")
local act = wezterm.action
return {
  font = wezterm.font("FiraMono Nerd Font"),
  font_size = 16.0,
  color_scheme = "tokyonight_night",
  enable_tab_bar = false,
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
