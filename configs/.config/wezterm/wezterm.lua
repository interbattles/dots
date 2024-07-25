local extra = require('extra')

local config = {
  enable_wayland = true,
	font = require("wezterm").font("JetBrainsMono Nerd Font"),
	color_schemes = {
		["matugen"] = require('colors.matugen'),
	},
  color_scheme = "matugen",
	default_cursor_style = "BlinkingBar",

	window_close_confirmation = "NeverPrompt",
	hide_tab_bar_if_only_one_tab = true,

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},
}

local function spread(template)
    local result = {}
    for key, value in pairs(template) do
        result[key] = value
    end

    return function(table)
        for key, value in pairs(table) do
            result[key] = value
        end
        return result
    end
end

return spread(config)(extra)
