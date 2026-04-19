#!/usr/bin/env bash

ICON_FULL=$(printf '\uf240')     # 
ICON_HIGH=$(printf '\uf241')     # 
ICON_MID=$(printf '\uf242')      # 
ICON_LOW=$(printf '\uf243')      # 
ICON_EMPTY=$(printf '\uf244')    # 
ICON_CHARGE=$(printf '\uf1e6')   # 

# Get battery info
BAT_PATH=$(ls /sys/class/power_supply/ | grep -i "bat" | head -n1)

if [ -z "$BAT_PATH" ]; then
    printf "%s AC" "$ICON_CHARGE"
    exit
fi

BAT_CAP=$(cat /sys/class/power_supply/${BAT_PATH}/capacity 2>/dev/null)
BAT_STATUS=$(cat /sys/class/power_supply/${BAT_PATH}/status 2>/dev/null)

# Pick icon by level
if   [ "$BAT_CAP" -ge 90 ]; then BAT_ICON="$ICON_FULL"
elif [ "$BAT_CAP" -ge 60 ]; then BAT_ICON="$ICON_HIGH"
elif [ "$BAT_CAP" -ge 30 ]; then BAT_ICON="$ICON_MID"
elif [ "$BAT_CAP" -ge 10 ]; then BAT_ICON="$ICON_LOW"
else                              BAT_ICON="$ICON_EMPTY"
fi

# Show charging icon if plugged in
if echo "$BAT_STATUS" | grep -qi "charging"; then
    BAT_ICON="$ICON_CHARGE"
fi

printf "%s %s%%" "$BAT_ICON" "$BAT_CAP"

case $BLOCK_BUTTON in
    3) notify-send -u low -t 6000 "Battery" \
"Level    ${BAT_CAP}%
Status   ${BAT_STATUS}" ;;
    6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
