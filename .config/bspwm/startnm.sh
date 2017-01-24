#!/usr/bin/zsh

if [[ $(pgrep -cf kde5-nm-connection-editor) -eq 0 ]]; then
    kde5-nm-connection-editor &
else
    killall kde5-nm-connection-editor
fi
