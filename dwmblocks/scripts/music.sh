#!/bin/sh

PLAYER=$(playerctl -l 2>/dev/null | head -n1)

[ -z "$PLAYER" ] && exit

STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ]; then
    ICON=" "
else
    ICON=" "
fi

playerctl metadata --format "$ICON{{ trunc(artist,10) }} - {{ trunc(title,15) }}"

