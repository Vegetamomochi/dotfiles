#!/bin/sh
/usr/bin/free -m | /usr/bin/awk '/Mem/ {printf " 󰘚 %.1fG/%.0fG", $3/1024, $2/1024}'
