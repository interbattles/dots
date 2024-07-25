local black = "#1b2023"
local red = "#ffb1c5"
local green = "#a1d399"
local yellow = "#ffb3b1"
local blue = "#9ecafc"
local magenta = "#d0bcfe"
local cyan = "#8bd0f0"
local white = "#c0c7cd"

local brblack = "#262b2e"
local brred = "#ffb1c6"
local brgreen = "#a1d399"
local bryellow = "#e4c36c"
local brblue = "#89d0ed"
local brmagenta = "#e3b7f3"
local brcyan = "#89d0ed"
local brwhite = "#dfe3e7"

return {
  foreground = '#dfe3e7',
  background = '#0f1417',

  cursor_bg = '#1b2023',
  cursor_fg = '#dfe3e7',
  cursor_border = '#40484d',

  selection_fg = '#2c3134',
  selection_bg = '#dfe3e7',

  scrollbar_thumb = '#c0c7cd',

  split = '#c0c7cd',

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

  compose_cursor = '#b5c9d7',

  copy_mode_active_highlight_bg = { Color = '#313539' },
  copy_mode_active_highlight_fg = { Color = '#dfe3e7' },
  copy_mode_inactive_highlight_bg = { Color = '#313539' },
  copy_mode_inactive_highlight_fg = { Color = '#dfe3e7' },

  quick_select_label_bg = { Color = '#364954' },
  quick_select_label_fg = { Color = '#d1e6f3' },
  quick_select_match_bg = { Color = '#004d67' },
  quick_select_match_fg = { Color = '#c1e8ff' },
}
