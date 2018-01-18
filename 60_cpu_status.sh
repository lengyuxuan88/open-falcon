#!/bin/sh
host_name=$(hostname)
ts=$(date +%s)
cpu_status=$(ipmitool -I open sdr | grep CPU | awk '{print $1="cpu_status""_"$2,$8}')
echo -e "$cpu_status" | while read n1 n2
do
    if [ "$n2" == "ok" ];then
        n2=0
    else
        n2=1
    fi
    curl -X POST -d "[{\"metric\": \"$n1\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": $n2,\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
done
