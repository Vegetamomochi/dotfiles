#!/bin/sh

# Monitor layout (external LEFT 100Hz, laptop RIGHT 60Hz)
xrandr --output HDMI-1 --mode 1920x1080 --rate 100 --primary \
       --output eDP-1 --mode 1366x768 --rate 60 --right-of HDMI-1 &

# Restore wal colors and wallpaper
wal -R &
feh --bg-fill ~/.cache/wal/wal.png &

# Start compositor + notifications + tray + bar
picom --config ~/.config/picom/picom.conf &
dunst &
nm-applet &
/usr/local/bin/dwmblocks -s &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

~/.local/bin/dpms-auto.sh &
exec dwm

