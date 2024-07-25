local black = "{{colors.surface_container.default.hex}}"
local red = "{{colors.color1.default.hex}}"
local green = "{{colors.color2.default.hex}}"
local yellow = "{{colors.color3.default.hex}}"
local blue = "{{colors.color4.default.hex}}"
local magenta = "{{colors.color5.default.hex}}"
local cyan = "{{colors.color6.default.hex}}"
local white = "{{colors.on_surface_variant.default.hex}}"

local brblack = "{{colors.surface_container_high.default.hex}}"
local brred = "{{colors.color9.default.hex}}"
local brgreen = "{{colors.color10.default.hex}}"
local bryellow = "{{colors.color11.default.hex}}"
local brblue = "{{colors.color12.default.hex}}"
local brmagenta = "{{colors.color13.default.hex}}"
local brcyan = "{{colors.color14.default.hex}}"
local brwhite = "{{colors.on_surface.default.hex}}"

return {
  foreground = '{{colors.on_background.default.hex}}',
  background = '{{colors.background.default.hex}}',

  cursor_bg = '{{colors.surface_container.default.hex}}',
  cursor_fg = '{{colors.on_surface.default.hex}}',
  cursor_border = '{{colors.outline_variant.default.hex}}',

  selection_fg = '{{colors.inverse_on_surface.default.hex}}',
  selection_bg = '{{colors.inverse_surface.default.hex}}',

  scrollbar_thumb = '{{colors.on_surface_variant.default.hex}}',

  split = '{{colors.on_surface_variant.default.hex}}',

  ansi = {
    black,
    red,
    green,
    yellow,
    blue,
    magenta,
    cyan,
    white,
  },
  brights = {
    brblack,
    brred,
    brgreen,
    bryellow,
    brblue,
    brmagenta,
    brcyan,
    brwhite,
  },

  compose_cursor = '{{colors.secondary.default.hex}}',

  copy_mode_active_highlight_bg = { Color = '{{colors.surface_container_highest.default.hex}}' },
  copy_mode_active_highlight_fg = { Color = '{{colors.on_surface.default.hex}}' },
  copy_mode_inactive_highlight_bg = { Color = '{{colors.surface_container_highest.default.hex}}' },
  copy_mode_inactive_highlight_fg = { Color = '{{colors.on_surface.default.hex}}' },

  quick_select_label_bg = { Color = '{{colors.secondary_container.default.hex}}' },
  quick_select_label_fg = { Color = '{{colors.on_secondary_container.default.hex}}' },
  quick_select_match_bg = { Color = '{{colors.primary_container.default.hex}}' },
  quick_select_match_fg = { Color = '{{colors.on_primary_container.default.hex}}' },
}
