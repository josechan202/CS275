#!/usr/bin/env python
from apns import APNs, Payload
import sys

#arguments ordered as: 0=scriptname 1=deviceHex 2=message
token_hex = sys.argv[1]
message = sys.argv[2]

apns = APNs(use_sandbox=True, cert_file='pushKeys/certfile.pem', key_file='pushKeys/keyfile.pem')
payload = Payload(alert=message, sound="default", badge=1)
apns.gateway_server.send_notification(token_hex, payload)
