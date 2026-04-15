local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "SF Mono"
  }),

  font_size = 12.5,

  window_background_opacity = 0.7,
  macos_window_background_blur = 35,

  colors = {
    foreground = "#d1ba8e",
    background = "#231e3b",
  },

  enable_tab_bar = true,
  window_decorations = "RESIZE",
  enable_scroll_bar = false,
  use_ime = true,
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
}
