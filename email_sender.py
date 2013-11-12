#!/usr/bin/env python
# Argument 1: email
# Argument 2: user name
# Argument 3: RPi ID

import requests
import sys
import time

if len(sys.argv) != 4:
    print "Error: incorrect parameters [email] [username] [RPi ID]"
    sys.exit(1)
 
url = "https://docs.google.com/a/kano.me/forms/d/1rYyIH4OG_sCmgSAr12iOX5tPRLL_dthLZEtZOkyFIeg/formResponse"
entryEmail = "entry.1842334521"
email = sys.argv[1]
entryName = "entry.1313297301"
name = sys.argv[2]
entryId = "entry.812659153"
id = sys.argv[3].split(":")[1]

info = {entryEmail: email, entryName: name, entryId: id}

numTries = 3
while numTries > 0:
    r = requests.post(url, data=info)
    if r.status_code == 200:
        break
    numTries -= 1
    time.sleep(1)

sys.exit(0)
