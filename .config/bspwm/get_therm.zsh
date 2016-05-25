#!/usr/bin/zsh

hwmondir=$(ls /sys/bus/platform/devices/coretemp.0/hwmon)

get_temp()
{
    temp_index=$1
    temp_value=$[$(cat /sys/bus/platform/devices/coretemp.0/hwmon/${hwmondir}/temp${temp_index}_input)/1000]
    if [[ "$temp_value" -gt 60 ]]; then
        temp_array[$1]="%{F#dc322f}$temp_value%{F-}"
    else
        temp_array[$1]=$temp_value
    fi
}

for i in `seq 2 5`; do
    get_temp $i
done

echo THR$temp_array
