#!/usr/bin/zsh
export GTK2_RC_FILES="$HOME/gtkrc-2.0"

IN="eDP-1"
EXT="HDMI-2"
EXT2="DP-1"
EXT3="DP-2"
EXT4="HDMI-3"

if (xrandr | grep "$EXT disconnected" && xrandr | grep "$EXT2 disconnected" && xrandr | grep "$EXT3 disconnected" && xrandr | grep "$EXT4 disconnected"); then
	xrandr --output $EXT --off --output $EXT2 --off --output $EXT3 --off --output $IN --auto
    #echo 'HDMI2 and DP1 and DP2 disconnected'
else
    if (xrandr | grep "$EXT disconnected" && xrandr | grep "$EXT2 disconnected" && xrandr | grep "$EXT4 disconnected"); then
        xrandr --output $IN --off --output $EXT --off --output $EXT2 --off --output $EXT3 --auto --output $EXT4 --off
        #echo 'DP2 connected; DP1 and HDMI2 disconnected'
    else
        if (xrandr | grep "$EXT disconnected" && xrandr | grep "$EXT3 disconnected" && xrandr | grep "$EXT4 disconnected"); then
            xrandr --output $IN --off --output $EXT --off --output $EXT2 --auto --output $EXT3 --off --output $EXT4 --off
        else
            if (xrandr | grep "$EXT disconnected" && xrandr | grep "$EXT3 disconnected" && xrandr | grep "$EXT2 disconnected"); then
                xrandr --output $IN --off --output $EXT --off --output $EXT2 --off --output $EXT3 --off --output $EXT4 --auto
            else
                xrandr --output $IN --off --output $EXT3 --off --output $EXT2 --off --output $EXT --auto --output $EXT4 --off
            fi
        fi
    fi
fi

bspc wm -d > "$BSPWM_STATE" && bspc quit
