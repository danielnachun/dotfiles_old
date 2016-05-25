#!/usr/bin/zsh

if [[ $(pgrep -c ksysguard) -eq 0 ]]; then
    ksysguard &
else
    killall ksysguard
fi

