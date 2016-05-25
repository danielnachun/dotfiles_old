#!/usr/bin/zsh

win_index=$(xdotool search --classname google-chrome getwindowname %@ | grep -nviE 'Google Sheets|Google Drive|Google Docs|Google Slides|google-chrome' | head -n 1 | cut -d ":" -f 1)
win_list=$(xdotool search --classname google-chrome)
win_format="0x$(printf '%08x\n' $win_list[(w)$win_index])"
echo $win_format
