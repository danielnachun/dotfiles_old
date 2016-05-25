#!/usr/bin/zsh
export KSH_ARRAYS=1

. $(dirname $0)/lemonbar_config.sh

shutdown="%{+u U${c_graygreen} T3 A1:oblogout:} ${icon_shutdown} %{-u A}"
while read -r line ; do
  case $line in
    SYS*)
      # conky, 0 = cpu, 1 = mem, 2 = bat_stat, 3 = bat_charge, 4 = net_up, 5 = net_down, 6 = weather, 7 = weekday, 8 = day, 9 = month, 10 = year, 11 = time
      sys_arr=(${line#???})

      # cpu
      cpu_percent=${sys_arr[0]}
      if [[ "${cpu_percent}" -gt 20 ]]; then
          cpu_color=${c_red}
      else
          cpu_color="-"
      fi
      cpu="%{+u U${c_lightgray} T5} ${icon_cpu} %{F${cpu_color} T1}$(printf '%+4s' ${sys_arr[0]}%) %{-u U- F-}"

      # mem
      mem="%{+u U${c_graygreen} T5} ${icon_memory} %{T1}$(printf '%+5s' ${sys_arr[1]}) %{-u U-}"

      #bat
      if [[ "${sys_arr[2]}" == "charged" ]]; then
          bat_icon="%{F${c_green}}%{T2}${icon_acon}%{F-}"
      else
          bat_icon="%{F${c_red}}%{T4}${icon_acoff}%{F-}"
      fi
      bat="%{+u U${c_lightblue}} ${bat_icon}%{T1} ${sys_arr[3]}% %{-u U-}"

      # wlan
      if [[ "${sys_arr[4]}" == "down" ]]; then
        wland_v="×"; wlanu_v="×";
        #wlan_cback=${color_sec_b2}; wlan_cicon=${color_sec_b3}; wlan_cfore=${color_sec_b3};
      else
        wland_v=${sys_arr[4]}; wlanu_v=${sys_arr[5]};
        #if [ ${wland_v:0:-3} -gt ${net_alert} ] || [ ${wlanu_v:0:-3} -gt ${net_alert} ]; then
          #wlan_cback=${color_net}; wlan_cicon=${color_back}; wlan_cfore=${color_back};
        #else
          #wlan_cback=${color_sec_b2}; wlan_cicon=${color_icon}; wlan_cfore=${color_fore};
        #fi
      fi

      wifistats=$(ip link show ${wifi_device} | head -n 1 | cut -d "," -f 3)
      if [[ "${wifistats}" == "UP" ]]; then
        net_icon="%{T2}${icon_wifi}"
      else
        net_icon="%{T5}${icon_ethernet}"
      fi
      wland="${wland_v}  "
      wlanu="${wlanu_v}  "
      net_down_icon="${icon_dl}"

      if grep -q "B" <<< $wland; then
        wland="00.0K"
      fi
      if grep -q "B" <<< $wlanu; then
        wlanu="00.0K"
      fi
      net_up_icon="${icon_ul}"
      net="%{+u U${c_lightgreen} A:'/home/daniel/.config/bspwm/startnm.sh':} ${net_icon}${stab}%{T3}${net_down_icon} %{T1}$(printf '%5s' $wland) %{T3}${net_up_icon} %{T1}$(printf '%5s' $wlanu) %{-u U- A}"

      #weather
      weather_temp=${sys_arr[6]}
      if [[ "${weather_temp}" -lt 60 ]]; then
         temp_col=${c_blue}
      else
         if [[ "${weather_temp}" -gt 79 ]]; then
             temp_col=${c_red}
         else
             temp_col=${c_green}
         fi
      fi

      weather="%{+u U${c_mediumblue} F${temp_col} T1} ${sys_arr[6]}%{F-}F %{-u U-}"

      # date
      date="%{+u U${c_lightgray} T3} ${icon_cal}%{T1} ${sys_arr[7]} ${sys_arr[8]} ${sys_arr[9]} ${sys_arr[10]} %{-u U-}"
      #date="%{B${color_bgdarkhl} T2}   ${icon_calendar} %{T1} ${date}"

      # time
      time="%{+u U${c_orange} T3} ${icon_clock} %{T1}${sys_arr[11]} %{-u U-}"
      ;;

    VOL*)
      ## Volume:
      ##   [0] Muted indicator: (M=Muted / (anything else)=Unmuted)
      ##   [1] On/off (muted) status (1=Unmuted / 0=Muted)
      vol_arr=(${line#???})
      vol_frg=-
      vol_oln=-
      vol_status=${vol_arr[0]}
      vol_txt=${vol_arr[1]}
      if [[ "${vol_status}" == "on" ]]; then
         vol_icon="%{F$c_green T2}${icon_vol_on}%{F-}"
      else
         vol_icon="%{F$c_red T2}${icon_vol_off}%{F-} "
      fi
      vol="%{+u U${c_lightred}} ${vol_icon}%{T1} $(printf '%+4s' $vol_txt)%{-u U-}"
      ;;
    
    THR*)
      thermal_arr=(${line#???})
      thermal="%{+u U${c_orange} T3} ${icon_thermal}%{T1} ${thermal_arr[@]} %{-u U-}"
      ;;
    BRI*)
      #if (xrandr | grep "$EXT connected" || xrandr | grep "$EXT2 connected" || xrandr | grep "$EXT3 connected" || xrandr | grep "$EXT4 connected"); then
          brightness=""
      #else
          #brightness_arr=(${line#???})
          #brightness="%{T3}${icon_brightness} %{T1} ${brightness_arr} "
      #fi
      ;;

    WM*)
      wsp=${line}

      #wsp="%{F${color_fglight} B${color_bgdark} T1}"
      #set -- ${line#???}
      #while [ $# -gt 0 ] ; do
        #case $1 in
         #FOC*)
           #wsp="${wsp}%{+u B${color_bgdarkhl} U${color_accent1} T1}   ${1##????}   %{-u B${color_bgdark} F${color_fglight}}"
           #;;
         #INA*|URG*|ACT*)
           #wsp="${wsp}%{F${color_fglight} T1}   ${1##????}   "
           #;;
        #esac
        #shift
      #done
      #;;
      
    #WIN*)
      ## window title
      #title=$(xprop -id ${line#???} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
      #title=" %{F- B- T1} ${title}"
      #;;
      
  esac

  # And finally, output
  #printf "%s\n" "%{U${color_accent1} l}${wsp} %{r}${ssid}${stab}${cpu}${stab}${vol}${stab}${batamt}${date}${stab}${time}"
  printf "%s\n" "%{r}%{A:/home/daniel/.config/bspwm/startksysguard.sh:}${cpu}${stab}${thermal}${stab}${mem}${stab}%{A}${brightness}${bat}${stab}${vol}${stab}${net}${stab}${weather}${stab}${date}${stab}${time}${stab}${shutdown}${stab}"
done
