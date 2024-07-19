return {
  enable_wayland = true,
	font = require("wezterm").font("JetBrainsMono Nerd Font"),
	default_cursor_style = "BlinkingBar",

	window_close_confirmation = "NeverPrompt",
	hide_tab_bar_if_only_one_tab = true,

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	window_background_opacity = 0.8,
	text_background_opacity = 1.0,
}
