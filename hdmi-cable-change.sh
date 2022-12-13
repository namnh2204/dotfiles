# !bin/sh
set -x
intern=eDP-1
extern=HDMI-1
if [[ $(xrandr --query | grep 'HDMI-1 connected') ]]; then
  xrandr --output $intern --auto --primary --output $extern --auto --right-of eDP-1
  bspc monitor $intern -d 1 2 3
  bspc monitor $extern -d 4 5 6
  feh --bg-fill ~/Pictures/Wallpapers/forest.jpg
else
  xrandr --output $intern --auto --output $extern --off
  bspc monitor $intern -d 1 2 3 4 5
fi
~/.config/polybar/launch.sh

