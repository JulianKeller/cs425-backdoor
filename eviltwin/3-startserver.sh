#!/bin/bash

# launches an apache server and copies our website from the repo to the server location

file=/var/www/html/index.html
echo "Copying index.html & script.js"
if [ -f "$file" ];
then
	sudo mv /var/www/html/index.html /var/www/html/index.html.old
fi

file2=/var/www/html/script.js
echo "script.js"
if [ -f "$file2" ];
then
	sudo mv /var/www/html/script.js /var/www/html/script.js.old
fi

cp -rva ../site/. /var/www/html
cd ../payloads

# copy the payloads
mkdir /var/www/html/payloads
cp -rva . /var/www/html/payloads/

echo "Files copied!"

echo "Starting Apache server..."
sudo /etc/init.d/apache2 start
echo "Apache started!"
