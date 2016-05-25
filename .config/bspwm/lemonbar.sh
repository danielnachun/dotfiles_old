#! /bin/bash

. $(dirname $0)/lemonbar_config.sh

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

conky -c $(dirname $0)/lemonbar_conky > "${panel_fifo}" &
xtitle -sf 'TITLE%s' > "${panel_fifo}" &

bspc config top_padding $(sed 's/x//g' <<< $geometry)
bspc subscribe report > "${panel_fifo}" &
count_volume=${upd_volume}
count_brightness=${upd_brightness}
count_thermal=${upd_thermal}
count_title=${upd_title}
count_locks=${upd_locks}

while :; do

  # Volume, "VOL"
  if [ $((count_volume++)) -ge ${upd_volume} ]; then
      sh $(dirname $0)/get_vol.sh > "${panel_fifo}" &
    count_volume=0
  fi

  # Brightness, "BRI"
  if [ $((count_brightness++)) -ge ${upd_brightness} ]; then
      printf "BRI%.0f\n" $(light -G) > "${panel_fifo}" &
    count_brightness=0
  fi

  # Thermal, "THR"
  if [ $((count_thermal++)) -ge ${upd_thermal} ]; then
      zsh $(dirname $0)/get_therm.zsh > "${panel_fifo}" &
    count_thermal=0
  fi

  if [ $((count_locks++)) -ge ${upd_locks} ]; then
      zsh $(dirname $0)/get_locks.zsh > "${panel_fifo}" &
    count_locks=0
  fi

  # Finally, wait 1 second
  sleep 0.5;

done &

cat "${panel_fifo}" | $(dirname $0)/lemonbar_parser.zsh | lemonbar -p -f "${font}" -o -1 -f "${iconfont}" -o -3 -f "${iconfont2}" -o -3 -f "${iconfont3}" -o -3 -f "${iconfont4}" -o -3 -g "${geometry}" -B "${color_back}" -F "${color_fore}" -u 3 -a 20 -n "bspwm_panel" | zsh &

wid=$(xdo id -a "bspwm_panel")
tries_left=20
while [ -z "$wid" -a "$tries_left" -gt 0 ] ; do
	sleep 0.05
	wid=$(xdo id -a "bspwm_panel")
	tries_left=$((tries_left - 1))
done
[ -n "$wid" ] && xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
