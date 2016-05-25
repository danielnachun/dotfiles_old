#!/usr/bin/zsh

caps=$(xset q | head -n 4 | tail -n 1 | tr -s ' ' | cut -d ' ' -f 5)
num=$(xset q | head -n 4 | tail -n 1 | tr -s ' ' | cut -d ' ' -f 9)
scroll=$(xset q | head -n 4 | tail -n 1 | tr -s ' ' | cut -d ' ' -f 13)

echo "LOCKS${caps} ${num} ${scroll}"
