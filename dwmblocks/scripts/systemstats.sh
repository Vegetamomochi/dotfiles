#!/usr/bin/env bash

# Icons via unicode escape (Hack Nerd Font)
ICON_TEMP=$(printf '\uf2c9')    # 
ICON_FLAME=$(printf '\uf490')   # 
ICON_CPU=$(printf '\uf4bc')     # 
ICON_RAM=$(printf '\uf85a')     # 

# ── CPU Temperature ───────────────────────────
CPU_TEMP=$(sensors 2>/dev/null | awk '
    /^Tdie|^Package id|^Core 0|^CPU|^temp1/ {
        gsub(/[+°C]/, "");
        for (i=1; i<=NF; i++) {
            if ($i ~ /^[0-9]+(\.[0-9]+)?$/) {
                gsub(/\..*/, "", $i);
                print $i; exit;
            }
        }
    }')
[ -z "$CPU_TEMP" ] && CPU_TEMP=$(sensors 2>/dev/null \
    | grep -E '^(Core 0|Package id 0|CPU)' \
    | awk '{print $3}' | tr -d '+°C' | head -n1)
[ -z "$CPU_TEMP" ] && CPU_TEMP="N/A"

if [ "$CPU_TEMP" != "N/A" ] && [ "$CPU_TEMP" -ge 80 ] 2>/dev/null; then
    TEMP_ICON="$ICON_FLAME"
else
    TEMP_ICON="$ICON_TEMP"
fi

# ── CPU Usage ────────────────────────────────
CPU_USE=$(top -bn1 | awk '/^%Cpu/ {printf "%.0f", 100 - $8}')
[ -z "$CPU_USE" ] && CPU_USE="0"

# ── RAM ──────────────────────────────────────
MEM_USED=$(free -m | awk '/^Mem/ {print $3}')
MEM_TOTAL=$(free -m | awk '/^Mem/ {print $2}')
MEM_PCT=$(( MEM_USED * 100 / MEM_TOTAL ))
MEM_GB=$(awk "BEGIN {printf \"%.1f\", $MEM_USED/1024}")
MEM_TOTAL_GB=$(awk "BEGIN {printf \"%.1f\", $MEM_TOTAL/1024}")

# ── Output ───────────────────────────────────
printf "%s %s°C   %s %s%%   %s %sg" \
    "$TEMP_ICON" "$CPU_TEMP" \
    "$ICON_CPU"  "$CPU_USE" \
    "$ICON_RAM"  "$MEM_GB"

# ── Click ────────────────────────────────────
case $BLOCK_BUTTON in
    1) setsid -f "$TERMINAL" -e htop ;;
    3) notify-send -u low -t 8000 "System" \
"CPU Temp   ${CPU_TEMP}°C
CPU Usage  ${CPU_USE}%
RAM        ${MEM_GB}g / ${MEM_TOTAL_GB}g (${MEM_PCT}%)" ;;
    6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
