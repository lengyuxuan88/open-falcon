#!/usr/bin/env python
#_*_ coding:utf-8 _*_
import commands
import socket
import json
import time
hostname = socket.gethostname()
ipmitool_cmd="ipmitool -I open sdr | grep Fans"
cmd_result = commands.getstatusoutput(ipmitool_cmd)
fans_result = cmd_result[1].split("|")[2].strip()

if fans_result == "ok":
    fans_status = 0
else:
    fans_status = 1

if __name__ == '__main__':
    s = [{"endpoint": hostname, "tags": "", "timestamp": int(time.time()), "metric": "fans.status", "value": fans_status, "counterType": "GAUGE", "step": 60}]
    print json.dumps(s)
