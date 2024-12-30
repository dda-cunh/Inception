#!/bin/bash

tar_file="latest.tar.gz"

if [ ! -d /var/www/html/wordpress ]; then
	curl -s https://wordpress.org/$tar_file --output $tar_file
	tar -xvf $tar_file > /dev/null
	mv wordpress /var/www/html/
	rm -rf $tar_file
fi

if [ ! -d /run/php/ ]; then
	sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf
	mkdir -p /run/php/
fi

php-fpm7.4 -F
