#!/bin/sh
http_status=$(curl -I -m 10 -o /dev/null -s -w %{http_code}"\r\n" 127.0.0.1/index.html)
host_name=$(hostname)
ts=$(date +%s)
curl -X POST -d "[{\"metric\": \"url_status\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": ${http_status},\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
