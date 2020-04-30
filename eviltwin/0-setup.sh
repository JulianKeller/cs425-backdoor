#! /bin/bash

# this script installs required packages and does some configuration setup

UPDATE=false
USB_WIFI_ADAPTER=1A:48:98:63:A6:7E

if [ "$UPDATE" = true ]; then
	# update the device
	sudo apt-get update

	# install dnsmasq
	sudo apt-get install dnsmasq dsniff mariadb-server

	# install
	git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/
	cd setoolkit
	pip3 install  Cython
	pip3 install -r requirements.txt
	python3 setup.py
fi
	
# Configure dns masq
echo -e "Configuring dnsmasq"
mkdir config
touch config/dnsmasq.conf
echo "interface=at0
dhcp-range=10.0.0.10,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
server=8.8.8.8
log-queries
log-dhcp
listen-address=127.0.0.1" > config/dnsmasq.conf

# check if the file was updated already
COUNT=$(grep -c "unmanaged-devices:mac=$USB_WIFI_ADAPTER" /etc/NetworkManager/NetworkManager.conf)
if [ $COUNT -eq 0 ]; then
	# Update NetworkManager.conf, Add these lines to the end: 
	echo -e "Configuring NetworkManager"
	echo "
[keyfile]
unmanaged-devices:mac=$USB_WIFI_ADAPTER" >> /etc/NetworkManager/NetworkManager.conf
fi

