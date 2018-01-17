#!/usr/bin/env python
#coding: utf-8
import os, sys, re
import json
import requests
import time
import urllib2, base64
from socket import *

def checkHttp(httpurl,neirong=''):
    try:
        r = requests.get(httpurl, timeout=3)
        if r.status_code in [ 200, 201, 301, 302]:
            pass
        else:
            return 111
	results = re.findall('%s'%neirong,r.text)
        if len(results) > 0:
            return 0
        else:
            return 111
    except Exception:
        return 111
def uploadToAgent(p):
    method = "POST"
    handler = urllib2.HTTPHandler()
    opener = urllib2.build_opener(handler)
    url = "http://127.0.0.1:1988/v1/push"
    request = urllib2.Request(url, data=json.dumps(p))
    request.add_header('Content-Type','application/json')
    request.get_method = lambda: method
    try:
        connection = opener.open(request)
    except urllib2.HTTPError,e:
        connection = e

    if connection.code == 200:
        print connection.read()
    else:
        print '{"err":1,"msg":"%s"}' % connection

def zuzhuangData(tags = '', value = ''):
    endpoint = "bj1-10-112-165-69"
    metric = "check_http_code"
    key = "remotehttpcheck"
    timestamp = int(time.time())
    step = 60
    vtype = "GAUGE"
    i = {
            'Metric' :'%s.%s'%(metric,key),
            'Endpoint': endpoint,
            'Timestamp': timestamp,
            'Step': step,
            'value': value,
            'CounterType': vtype,
            'TAGS': tags
            }
    return i

p = []
with open("./remotehttpcheck.txt") as f:
    for line in f:
        results = re.findall("(\S+)",line)
        print results
        httpurl = results[0]
        description = results[1]
        neirong = results[2]
        tags = "httpurl=%s,description=%s,neirong=%s"%(httpurl,description,neirong)
        value = checkHttp(httpurl,neirong)
        p.append(zuzhuangData(tags,value))
print json.dumps(p, sort_keys=True,indent = 4)
uploadToAgent(p)
