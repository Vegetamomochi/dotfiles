#!/usr/bin/env bash

ICON_WIFI=$(printf '\uf1eb')
ICON_ETH=$(printf '\uf6ff')
ICON_OFF=$(printf '\uf127')

CONN=$(nmcli -t -f NAME,TYPE,STATE con show --active 2>/dev/null \
    | grep ':activated' | head -n1)
CONN_NAME=$(echo "$CONN" | cut -d: -f1)
CONN_TYPE=$(echo "$CONN" | cut -d: -f2)

if   echo "$CONN_TYPE" | grep -qi "wireless"; then NET_ICON="$ICON_WIFI"
elif echo "$CONN_TYPE" | grep -qi "ethernet"; then NET_ICON="$ICON_ETH"
elif [ -n "$CONN_NAME" ];                        then NET_ICON="$ICON_WIFI"
else CONN_NAME="offline";                             NET_ICON="$ICON_OFF"
fi

# Truncate to 5 chars + … if longer
if [ "${#CONN_NAME}" -gt 5 ]; then
    CONN_SHORT="${CONN_NAME:0:5}…"
else
    CONN_SHORT="$CONN_NAME"
fi

printf "%s %s" "$NET_ICON" "$CONN_SHORT"

case $BLOCK_BUTTON in
    1) notify-send -u low -t 6000 "Network" "$CONN_NAME" ;;
    6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
