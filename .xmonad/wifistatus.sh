#!/usr/bin/sh

wifion=$(ifconfig | grep wlp6s0)
if [ -z "$wifion" ]; then
    echo "<icon=wifioff.xpm/>" > /tmp/wifistatus
else
    echo "<icon=wifion.xpm/>" > /tmp/wifistatus
fi

exit
