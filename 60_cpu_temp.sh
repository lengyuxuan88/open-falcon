#!/bin/sh
host_name=$(hostname)
ts=$(date +%s)
cpu_temp=$(ipmitool -I open sdr | grep CPU | awk '{print $1="cpu_temp""_"$2,$4}')
echo -e "$cpu_temp" | while read cpu temp
do
    curl -X POST -d "[{\"metric\": \"$cpu\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": $temp,\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
done
