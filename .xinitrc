#!/bin/sh

# =============================================
# DISPLAY
# =============================================
xrandr --output HDMI-1 --mode 1920x1080 --rate 100 --primary \
       --output eDP-1 --mode 1366x768 --rate 60 --right-of HDMI-1 &

# =============================================
# CURSOR
# =============================================
echo "Xcursor.size: 24" | xrdb -merge
xsetroot -cursor_name left_ptr &

# =============================================
# WALLPAPER & COLORS
# =============================================
feh --bg-scale /home/vegeta/Wallpaper/wallpaper.jpg &
wal -i /home/vegeta/Wallpaper/wallpaper.jpg -n -q
xrdb -merge ~/.cache/wal/colors.Xresources

# =============================================
# COMPOSITOR
# =============================================
picom -b &

# =============================================
# STATUS BAR
# =============================================
dwmblocks &

# =============================================
# SYSTEM
# =============================================
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# =============================================
# LAUNCH DWM
# =============================================
exec dwm
