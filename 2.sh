#!/bin/sh
host_name=`hostname`
ts=`date +%s`
dimm_num=`hpasmcli -s "show dimm" | grep Processor | wc -l`

Processor=(`hpasmcli -s "show dimm" | grep Processor | awk  '{print $1"_"$3}'`)

Module=(`hpasmcli -s "show dimm" | grep Module | awk '{print $1"_"$3}'`)

Status=(`hpasmcli -s "show dimm" | grep Status | awk '{print $2}'`)

dimm_status=$(
for ((i=0;i<$dimm_num;i++))
do
    echo DIMM_${Processor[$i]}_${Module[$i]}  ${Status[$i]}
done
)

echo "$dimm_status" | while read name status
do
    if [ "$status" == "Ok" ];then
        status=0
    else
        status=1
    fi
    curl -X POST -d "[{\"metric\": \"$name\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": $status,\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
done

