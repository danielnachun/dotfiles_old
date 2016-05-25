#!/usr/bin/zsh

brightness=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)

echo BRI$[brightness/max_brightness*100]
