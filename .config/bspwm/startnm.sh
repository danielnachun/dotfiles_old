#!/usr/bin/zsh

if [[ $(pgrep -c "nm-connection") -eq 0 ]]; then
    nm-connection-editor &
else
    killall nm-connection-editor
fi
