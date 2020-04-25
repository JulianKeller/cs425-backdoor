#!/bin/bash

file=/var/www/html/index.html
echo "Copying index.html & script.js"
if [ -f "$file" ];
then
	sudo mv /var/www/html/index.html /var/www/html/index.html.old
fi

file2=/var/www/html/script.js
echo "Copying index.html & script.js"
if [ -f "$file2" ];
then
	sudo mv /var/www/html/script.js /var/www/html/script.js.old
fi

sudo cp ../site/index.html ../site/script.js /var/www/html
echo "Files copied!"

echo "Starting Apache server..."
sudo /etc/init.d/apache2 start
echo "Apache started!"
