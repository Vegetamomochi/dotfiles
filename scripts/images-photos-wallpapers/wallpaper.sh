#!/bin/bash

WALLPAPER_DIR="/home/vegeta/Wallpaper"
TEMP_DIR="/home/vegeta/Wallpaper/.current"
CURRENT="$TEMP_DIR/wallpaper.jpg"

# --- Create temp dir if not exists ---
mkdir -p "$TEMP_DIR"

# --- Remove old temp wallpaper ---
rm -f "$TEMP_DIR"/*

# --- Copy selected image as wallpaper.jpg ---
SELECTED="$1"
if [ -z "$SELECTED" ]; then
    echo "Usage: wallpaper.sh /path/to/image.jpg"
    exit 1
fi

cp "$SELECTED" "$CURRENT"
echo "Set $SELECTED → current wallpaper"

# --- Apply wallpaper ---
feh --bg-scale "$CURRENT" &

# --- Generate colorscheme (force, no cache) ---
rm -f ~/.cache/wal/schemes/*.json 2>/dev/null
wal -i "$CURRENT" -n

# --- Write dmenu xresources ---
source ~/.cache/wal/colors.sh
cat >> ~/.cache/wal/colors.Xresources << XEOF
dmenu.background: $background
dmenu.foreground: $foreground
dmenu.selbackground: $color1
dmenu.selforeground: $background
XEOF

# --- Reload Xresources ---
xrdb -merge ~/.cache/wal/colors.Xresources

# --- Reload st ---
pkill -x -SIGUSR1 st

echo "Done! Colors updated for st and dmenu."
