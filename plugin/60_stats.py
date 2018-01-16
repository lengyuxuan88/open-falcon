#!/usr/bin/python

import time
import json
import os
host_name=os.system("hostname")

output = [{"endpoint": "$host_name", "tags": "", "timestamp": int(time.time()), "metric": "agent.cpu", "value": 1.8, "counterType": "GAUGE", "step": 60}]

print  json.dumps(output)
