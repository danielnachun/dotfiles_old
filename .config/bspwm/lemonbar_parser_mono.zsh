#!/usr/bin/zsh

. $(dirname $0)/lemonbar_config.sh

shutdown="%{+u U${c_graygreen} T3 A1:oblogout:} ${icon_shutdown} %{-u A}"

while read -r line ; do
  case $line in
    SYS*)
      # conky, 1 = cpu, 2 = mem, 3 = bat_stat, 4 = bat_charge, 5 = net_up, 6 = net_down, 7 = weather, 8 = weekday, 9 = day, 10 = month, 11 = year, 12 = time
      sys_arr=${line#???}

      # cpu
      cpu_percent=$sys_arr[(w)1]
      if [[ "${cpu_percent}" -gt 20 ]]; then
          cpu_color=${c_red}
      else
          cpu_color="-"
      fi
      if [[ ${#cpu_percent} -eq 1 ]]; then
          cpu_percent="${cpu_percent}.00"
      fi
      if [[ ${#cpu_percent} -eq 2 ]]; then
          cpu_percent="${cpu_percent}.0"
      fi
      cpu="%{+u U${c_lightgray} T5} ${icon_cpu} %{F${cpu_color} T1}$(printf '%+4s' ${cpu_percent}%{F-}%) %{-u U-}"

      # mem
      mem="%{+u U${c_graygreen} T5} ${icon_memory} %{T1}$(printf '%+5s' $sys_arr[(w)2]) %{-u U-}"

      #bat
      if [[ "$sys_arr[(w)3]" == "charged" ]]; then
          bat_icon="%{F${c_green}}%{T2}${icon_acon}%{F-}"
      else
          bat_icon="%{F${c_red}}%{T4}${icon_acoff}%{F-}"
      fi
      bat="%{+u U${c_lightblue}} ${bat_icon}%{T1} $sys_arr[(w)4]% %{-u U-}"

      # wlan
      if [[ "$sys_arr[(w)5]" == "down" ]]; then
        wland_v="×"; wlanu_v="×";
      else
          wland_v=$sys_arr[(w)5]; wlanu_v=$sys_arr[(w)6];
      fi

      wifistats=$(ip link show ${wifi_device} | head -n 1 | cut -d "," -f 3)
      if [[ "${wifistats}" == "UP" ]]; then
        net_icon="%{T2}${icon_wifi}"
      else
        net_icon="%{T5}${icon_ethernet}"
      fi
      wland="${wland_v}"
      #if [[ echo $wlan ]]
      wlanu="${wlanu_v}"
      net_down_icon="${icon_dl}"

      if grep -q "B" <<< $wland; then
        wland="00.0K"
      fi
      if grep -q "B" <<< $wlanu; then
        wlanu="00.0K"
      fi

      if grep -q "K" <<< $wland; then
          wland=$(sed 's/K/K /' <<< $wland)
      fi
      if grep -q "K" <<< $wlanu; then
          wlanu=$(sed 's/K/K /' <<< $wlanu)
      fi
      net_up_icon="${icon_ul}"
      net="%{+u U${c_lightgreen} A:'/home/daniel/.config/bspwm/startnm.sh':} ${net_icon}${stab}%{T3}${net_down_icon} %{T1}$(printf '%5s' $wland)  %{T3}${net_up_icon} %{T1}$(printf '%5s' $wlanu) %{-u U- A}"

      #weather
      weather_temp=$sys_arr[(w)7]
      if [[ "${weather_temp}" -lt 60 ]]; then
         temp_col=${c_blue}
      else
         if [[ "${weather_temp}" -gt 79 ]]; then
             temp_col=${c_red}
         else
             temp_col=${c_green}
         fi
      fi

      weather="%{+u U${c_mediumblue} F${temp_col} T1} $sys_arr[(w)7]%{F-}F %{-u U-}"

      # date
      date="%{+u U${c_lightgray} T3} ${icon_cal}%{T1} $sys_arr[(w)8] $sys_arr[(w)9] $sys_arr[(w)10] $sys_arr[(w)11] %{-u U-}"

      # time
      time="%{+u U${c_orange} T3} ${icon_clock} %{T1}$sys_arr[(w)12] %{-u U-}"
      ;;

    VOL*)
      vol_arr=${line#???}
      vol_frg=-
      vol_oln=-
      vol_status=$vol_arr[(w)1]
      vol_txt=$vol_arr[(w)2]
      vol_txt=$(sed 's/%//' <<< $vol_txt)
      if [[ "${vol_status}" == "on" ]]; then
         vol_icon="%{F$c_green T2}${icon_vol_on}%{F-}"
      else
         vol_icon="%{F$c_red T2}${icon_vol_off}%{F-} "
      fi

      if [[ ${#vol_txt} -eq 1 ]]; then
          vol_txt="${vol_txt}.00"
      fi
      if [[ ${#vol_txt} -eq 2 ]]; then
          vol_txt="${vol_txt}.0"
      fi
      vol="%{+u U${c_lightred}} ${vol_icon}%{T1} $(printf '%+4s' $vol_txt%) %{-u U-}"
      ;;
    
    THR*)
      thermal_arr=(${line#???})
      thermal="%{+u U${c_orange} T3} ${icon_thermal}%{T1}$thermal_arr %{-u U- F-}"
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
      wsp=${line#?}
      wsp_array=("${(@s/:/)wsp}")
      wsp_output="%{-u}"

      foreach desktop ({2..$n_desktops})
          current_desktop=$wsp_array[(w)$desktop]
          case $current_desktop in
             O*)
                wsp_output="${wsp_output}  %{+u U${c_orange}}  $[$desktop-1]  %{-u U-}"
                ;;
             F*)
                wsp_output="${wsp_output}  %{+u U${c_orange}}  $[$desktop-1]  %{-u U-}"
                ;;
             o*)
                wsp_output="${wsp_output}  %{+u U${c_lightgray} A:bspc desktop -f $[$desktop-1]:}  $[$desktop-1]  %{-u U- A}"           
                ;;
          esac
      end
      ;;
     
      
    TITLE*)
      title=${line#?????}
      ;;

    LOCKS*)
      locks=${line#?????}
      lock_string=""
      if [[ $locks[(w)1] == "on" ]]; then
          lock_string="${lock_string}${stab}%{U${c_graygreen} +u} CAPS %{-u U-}"
      fi
      if [[ $locks[(w)2] == "on" ]]; then
          lock_string="${lock_string}${stab}%{U${c_lightblue} +u} NUM %{-u U-}"
      fi
      if [[ $locks[(w)3] == "on" ]]; then
          lock_string="${lock_string}${stab}%{U${c_lightred} +u} SCROLL %{-u U-}"
      fi
      ;;
      
  esac

  # And finally, output
  printf "%s\n" "%{l}${wsp_output}${stab}${title}%{r} ${lock_string}${stab}${net}${stab}%{A:/home/daniel/.config/bspwm/startksysguard.sh:}${cpu}${stab}${thermal}${stab}${mem}${stab}%{A}${brightness}${bat}${stab}${vol}${stab}${weather}${stab}${date}${stab}${time}${stab}${shutdown}${stab}"
done
