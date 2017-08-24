#!/bin/bash

stab=' '
geometry="x26"
fontsize="10"
panel_fifo="/tmp/lemonbar_${USER}"
monofont="MesloLGM Nerd Font-${fontsize}"
sansfont="Noto Sans-${fontsize}"
iconfont="FontAwesome-${fontsize}"
iconfont2="EightyShades-${fontsize}"
iconfont3="DanielIcons-${fontsize}"
iconfont4="Icons-${fontsize}"
#iconfont3="FontCustom-${fontsize}"
#iconfont5="Foundation-${fontsize}"
#iconfont6="Batch-${fontsize}"

c_dark_background="#33393B"
c_background="#00000000"
c_green="#98c379"
c_red="#c06c75"
c_blue="#61afef"
c_blue_foreground="#61afef"
c_blue_foreground_light="#9061afef"
#c_foreground_light="#90f3f3f5"
c_orange="#d19a66"
c_purple="#c678dd"
c_mediumblue="#c678dd"
c_lightgreen="#98c379"
c_lightred="#c06c75"
c_lightblue="#c678dd"
c_graygreen="#56b6c2"
c_lightgray="#dedae3"
c_white="#dedae3"
c_foreground="#61afef"

color_bgdark="$c_background"
color_fglight="$c_foreground"

upd_volume=1
upd_brightness=1
upd_thermal=1
upd_title=1
upd_locks=1

color_fore="$color_fglight"
color_back="$color_bgdark"

#Font Awesome
icon_dl=$(printf "\uf063")
icon_ul=$(printf "\uf062")
icon_cal=$(printf "\uf073")
icon_clock=$(printf "\uf017")
icon_wifi=$(printf "\uf1eb")
icon_brightness=$(printf "\uf39b")
icon_acon=$(printf "\uf1e6")
icon_shutdown=$(printf "\uf011")
icon_plus=$(printf "\uf067")
icon_minus=$(printf "\uf068")
icon_circle=$(printf "\uf10c")
icon_dot=$(printf "\uf111")
icon_previous=$(printf "\uf049")
icon_next=$(printf "\uf050")
icon_play=$(printf "\uf04b")
icon_pause=$(printf "\uf04c")

#Icons
icon_thermal=$(printf "\uf3b6")

#Unknown
icon_acoff=$(printf "\uf240")

#Eight Shades
icon_vol_on=$(printf "\ue01b")
icon_vol_off=$(printf "\ue01d")

#Daniel Icons
icon_ethernet=$(printf "\u02b1")
icon_memory=$(printf "\u02b2")
icon_cpu=$(printf "\u02b0")

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
