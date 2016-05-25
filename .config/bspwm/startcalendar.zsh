#!/usr/bin/zsh

if [[ $(pgrep -c gsimplecal) -eq 0 ]]; then
    gsimplecal &
else
    killall gsimplecal
fi

