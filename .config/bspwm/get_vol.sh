#!/bin/zsh

vol_status=$(amixer get Master | tail -n 1 | cut -d '[' -f 3 | sed 's/].*//g')
vol_level=$(amixer get Master | tail -n 1 | cut -d '[' -f 2 | sed 's/].*//g')

echo "VOL $vol_status $vol_level" > /tmp/lemonbar_daniel & 
