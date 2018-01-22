#!/bin/sh
host_name=`hostname`
ts=`date +%s`
Fans_status=`ipmitool -I open sdr | grep Fans | awk '{print $5}'`
if [ "$Fans_status" == "ok" ];then
    Fans_status=0
else
    Fans_status=1
fi
curl -X POST -d "[{\"metric\": \"fans_status\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": $Fans_status,\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
