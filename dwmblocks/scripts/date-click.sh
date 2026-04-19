#!/bin/sh
case $BLOCK_BUTTON in
    1) st -e sh -c "cal -y | less" ;;  # left click - show calendar
esac
/usr/bin/date "+ 󰸘 %a %d %b  󰥔 %I:%M %p"
