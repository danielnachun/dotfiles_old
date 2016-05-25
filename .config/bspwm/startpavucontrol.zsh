#!/usr/bin/zsh

if [[ $(pgrep -c pavucontrol) -eq 0 ]]; then
    pavucontrol &
else
    killall pavucontrol
fi

