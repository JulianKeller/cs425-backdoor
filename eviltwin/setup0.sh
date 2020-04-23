#! /bin/bash

# this script installs required packages and does some configuration setup

UPDATE=false
BRIDGE=wlan0 			# connected to internet, could be eth0 too
WLAN=wlan1			# monitor mode wirless adapter
MON=mon
WLANMON=$WLAN$MON
ESSID=TEST
CHANNEL=11

if [ "$UPDATE" = true ]; then
	# update the device
	sudo apt-get update

	# install dnsmasq
	sudo apt-get install dnsmasq

	# Update Device
	sudo apt-get update
		
	# Install dnsmasq
	apt-get install dnsmasq
fi
	
# Configure dns masq
echo -e "Configuring dnsmasq"
mkdir /root/Desktop/eviltwin
touch /root/Desktop/eviltwin/dnsmasq.conf
echo "interface=at0
dhcp-range=10.0.0.10,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
server=8.8.8.8
log-queries
log-dhcp
listen-address=127.0.0.1" >> /root/Desktop/eviltwin/dnsmasq.conf

# check if the file was updated already
COUNT=$(grep -c "unmanaged-devices:mac=AA:BB:CC:DD:EE:FF, A2:B2:C2:D2:E2:F2" /etc/NetworkManager/NetworkManager.conf)
if [ $COUNT -eq 0 ]; then
	# Update NetworkManager.conf, Add these lines to the end: 
	echo -e "Configuring NetworkManager"
	echo "
[keyfile]
unmanaged-devices:mac=AA:BB:CC:DD:EE:FF, A2:B2:C2:D2:E2:F2" >> /etc/NetworkManager/NetworkManager.conf
fi
