#!/usr/bin/env python
#_*_ coding:utf-8 _*_
import socket
import commands
import time
import json
hostname = socket.gethostname()
power_cmd = "ipmitool -I open sdr list | grep 'Power Supply'"
cmd_output = commands.getstatusoutput(power_cmd)
a =  cmd_output[1].split("|")[2]
#a = cmd_output[1].split("|")[2].strip()
for i in a:
    print i

#output_list = []
#output_list.append(cmd_output[1])
#print output_list.split("|").strip()
