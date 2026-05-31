#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

if [ -f "$sysresources" ]; then
    "$xrdb" -merge "$sysresources"
fi

if [ -f "$userresources" ]; then
    "$xrdb" -merge "$userresources"
fi

if [ -d "$xinitdir"/xinitrc.d ] ; then
        for f in "$xinitdir/xinitrc.d"/?*.sh ; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

# 1. Fix the giant cursor size immediately
echo "Xcursor.size: 24" | xrdb -merge &
xsetroot -cursor_name left_ptr &

# 2. Dual Display Setup (100Hz Monitor Left, 60Hz 1366x768 Laptop Right)
xrandr --output HDMI-1 --mode 1920x1080 --rate 100 --primary \
       --output eDP-1 --mode 1366x768 --rate 60 --right-of HDMI-1 &

# 3. Start background tools (Corrected Wallpaper Path & Transparency)
feh --bg-scale /home/vegeta/Wallpaper/wallpaper.jpg &
picom -b &

# 4. Start your status bar modules
dwmblocks &

# 5. Launch dwm
exec dwm
