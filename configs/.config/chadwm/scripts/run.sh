#!/bin/sh

# xbacklight -set 10 &
# xset r rate 200 50 &

xrdb merge ~/.Xresources 
feh --bg-fill ~/walls/a_close_up_of_moss_on_a_branch.jpg &
picom &
xss-lock -- betterlockscreen -l dimblur &

dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done

