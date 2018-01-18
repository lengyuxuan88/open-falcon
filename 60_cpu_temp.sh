#!/bin/sh
host_name=$(hostname)
ts=$(date +%s)
cpu_temp=$(ipmitool -I open sdr | grep CPU | awk '{print $1="cpu_temp""_"$2,$4}')
echo -e "$cpu_temp" | while read n1 n2
do
    curl -X POST -d "[{\"metric\": \"$n1\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": $n2,\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
done
