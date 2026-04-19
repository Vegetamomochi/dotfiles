#!/usr/bin/env bash

ICON_SUNNY=$(printf '\uf185')
ICON_CLOUDY=$(printf '\uf0c2')
ICON_RAINY=$(printf '\uf740')
ICON_SNOWY=$(printf '\uf2dc')
ICON_STORM=$(printf '\uf0e7')
ICON_FOG=$(printf '\uf74e')

WEATHER=$(curl -sf "https://wttr.in/Bilaspur+Himachal+Pradesh?format=%t+%C" 2>/dev/null)

[ -z "$WEATHER" ] && printf "? --" && exit

TEMP=$(echo "$WEATHER" | awk '{print $1}')
DESC=$(echo "$WEATHER" | cut -d' ' -f2- | tr '[:upper:]' '[:lower:]')

if   echo "$DESC" | grep -qi "sunny\|clear";    then W_ICON="$ICON_SUNNY"
elif echo "$DESC" | grep -qi "cloud\|overcast"; then W_ICON="$ICON_CLOUDY"
elif echo "$DESC" | grep -qi "rain\|drizzle";   then W_ICON="$ICON_RAINY"
elif echo "$DESC" | grep -qi "snow\|blizzard";  then W_ICON="$ICON_SNOWY"
elif echo "$DESC" | grep -qi "storm\|thunder";  then W_ICON="$ICON_STORM"
elif echo "$DESC" | grep -qi "fog\|mist\|haze"; then W_ICON="$ICON_FOG"
else                                                 W_ICON="$ICON_SUNNY"
fi

printf "%s %s" "$W_ICON" "$TEMP"

case $BLOCK_BUTTON in
    1) notify-send -u low -t 10000 "Weather - Bilaspur HP" \
        "$(curl -sf 'https://wttr.in/Bilaspur+Himachal+Pradesh?format=3' 2>/dev/null)" ;;
    6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
