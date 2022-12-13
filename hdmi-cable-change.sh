# !bin/sh
set -x
intern=eDP
extern=HDMI-A-0
if [[ $(xrandr --query | grep "$extern connected") ]]; then
  xrandr --output $intern --auto --primary --output $extern --scale 1.75x1.75 --auto --right-of $intern
  bspc monitor $intern -d 1 2 3
  bspc monitor $extern -d 4 5 6
  feh --bg-fill ~/Pictures/Wallpapers/forest.jpg
else
  xrandr --output $intern --auto --output $extern --off
  bspc monitor $intern -d 1 2 3 4 5
fi
~/.config/polybar/launch.sh

