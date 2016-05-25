#!/usr/bin/zsh

if [[ $(pgrep -c gnome-weather) -eq 0 ]]; then
    gnome-weather &
else
    killall gnome-weather
fi

