#!/bin/sh
host_name=`hostname`
name=$(ipmitool -I open sdr list | grep 'Power Supply'| awk '{print $1"_"$2"_"$3,$8}')
#echo $name
ts=`date +%s`
echo -e "$name" | while read c1 c2 
do
    for i in "$c2"
    do
        if [ "$i" == "ok" ];then 
            c2=0
	else
	    c2=1
        fi
        curl -X POST -d "[{\"metric\": \"$c1\", \"endpoint\": \"${host_name}\", \"timestamp\": $ts,\"step\": 60,\"value\": $c2,\"counterType\": \"GAUGE\"}]" http://127.0.0.1:1988/v1/push
    done
done

