#!/usr/bin/env bash

ICON_SUN=$(printf '\uf185')     # 
ICON_CLOUD=$(printf '\uf6c4')   # 
ICON_MOON=$(printf '\uf186')    # 
ICON_STARS=$(printf '\uf051')   # 
ICON_CAL=$(printf '\uf073')     # 
ICON_CLOCK=$(printf '\uf017')   # 

H24=$(date '+%H')
if   [ "$H24" -ge 5  ] && [ "$H24" -lt 12 ]; then TIME_ICON="$ICON_SUN"
elif [ "$H24" -ge 12 ] && [ "$H24" -lt 17 ]; then TIME_ICON="$ICON_CLOUD"
elif [ "$H24" -ge 17 ] && [ "$H24" -lt 21 ]; then TIME_ICON="$ICON_MOON"
else                                               TIME_ICON="$ICON_STARS"
fi

printf "%s %s   %s %s" \
    "$ICON_CAL" "$(date '+%a %d %b')" \
    "$TIME_ICON" "$(date '+%I:%M %p')"

case $BLOCK_BUTTON in
    1) notify-send -u low -t 8000 "Calendar" "$(cal)" ;;
    6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
