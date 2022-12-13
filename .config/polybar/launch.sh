#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1, bar2, bar3, bar4
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log /tmp/polybar4.log

#polybar black >>/tmp/polybar1.log 2>&1 & disown
polybar bar1 -r >>/tmp/polybar1.log 2>&1 & disown
polybar bar2 -r >>/tmp/polybar2.log 2>&1 & disown
# polybar bar3 -r >>/tmp/polybar3.log 2>&1 & disown
# polybar bar4 -r >>/tmp/polybar4.log 2>&1 & disown
echo "Bars launched..."
