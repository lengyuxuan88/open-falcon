#!/bin/sh
login_number=$(uptime | awk -F ',' '{print $2}' | awk '{print $1}')
host_name=$(hostname)
ts=$(date +%s)
curl -X POST -d "[{\"metric\": \"login_user\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": ${login_number},\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
