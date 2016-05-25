#!/bin/bash

stab=' '
geometry="x26"
fontsize="10"
panel_fifo="/tmp/lemonbar_${USER}"
font="Oxygen Mono-${fontsize}"
iconfont="FontAwesome-${fontsize}"
iconfont2="Icons-${fontsize}"
iconfont3="FontCustom-${fontsize}"
iconfont4="DanielIcons-${fontsize}"

c_background="#00000000"
c_green="#66aa11"
c_red="#dc322f"
c_blue="#2e86e3"
c_foreground="#f3f3f5ff"
c_orange="#ff9900"
c_purple="#542437"
c_mediumblue="#2699BF"
c_lightgreen="#c7f464"
c_lightred="#ff6b6b"
c_lightblue="#4ecdc4"
c_graygreen="#53777a"
c_lightgray="#e0e4cc"

color_bgdark="$c_background"
color_fglight="$c_foreground"

upd_volume=1
upd_brightness=1
upd_thermal=1
upd_title=1
upd_locks=1

color_fore="$color_fglight"
color_back="$color_bgdark"

icon_dl=$(printf "\uf063")
icon_ul=$(printf "\uf062")
icon_cal=$(printf "\uf073")
icon_clock=$(printf "\uf017")
icon_wifi=$(printf "\uf1eb")
icon_ethernet=$(printf "\u0043")
icon_brightness=$(printf "\uf39b")
icon_acon=$(printf "\uf1e6")
icon_acoff=$(printf "\uf116")
icon_vol_on=$(printf "\uf028")
icon_vol_off=$(printf "\uf026")
icon_thermal=$(printf "\uf3b6")
icon_shutdown=$(printf "\uf011")
icon_memory=$(printf "\u0041")
icon_cpu=$(printf "\u0042")

icon_chrome=$(printf "\uf268") #Font Awesome
icon_hangouts=$(printf "\uf3d4") #Font Icons
#icon_mendeley=
icon_filebrowser=$(printf "\uf07c") #Font Awesome 
icon_notes=$(printf "\uf249") #Font Awesome
#icon_terminal Batch

#Icon
#icon_tmux
#icon_libreoffice \uf15c \f22e 
#icon_text \uf0c9
#icon_music \uf2bc \uf30c 

#Awesome
#icon_libreoffice \uf15b
#icon_terminal \uf120



wifi_device="wlp6s0"
EXT="HDMI-2"
EXT2="DP-1"
EXT3="DP-2"
EXT4="HDMI-3"

n_desktops=10
