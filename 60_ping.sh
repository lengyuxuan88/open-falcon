#!/bin/bash
#
IDC_HOST="qd.zhxfei.com sh.zhxfei.com"
ts=`date +%s`;
for host in ${IDC_HOST}
do
    RTT_TIME=`ping -c 1 ${host}| tail -n 1| awk -F'/' '{print $5}'`
    curl -X POST -d "[{\"metric\": \"net.latency.hk.zhxfei.com-${host}\", \"endpoint\": \"${host}\", \"timestamp\": $ts,\"step\": 60,\"value\": ${RTT_TIME},\"counterType\": \"GAUGE\",\"tags\": \"idc=hk,project=latency_test\"}]" http://127.0.0.1:1988/v1/push
done
