#!/usr/bin/zsh

IN="eDP-1"
EXT="HDMI-2"
EXT2="DP-1"
EXT3="DP-2"

if (xrandr | grep "$EXT connected"); then
	xrandr --output $EXT --off 
fi
if (xrandr | grep "$EXT2 connected"); then
    xrandr --output $EXT2 --off
fi
if (xrandr | grep "$EXT3 connected"); then
    xrandr --output $EXT3 --off
fi
xrandr --output $IN --auto

if [ $(pgrep trayer) ]; then
    killall trayer
fi

#/home/daniel/.xmonad/starttrayer.sh   
#/home/daniel/.xmonad/setdesktop.sh

