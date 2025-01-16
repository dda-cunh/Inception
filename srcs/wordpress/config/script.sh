#!/bin/bash

wp_archive="latest.tar.gz"
wp_is_setup="/service/.wp_is_setup"
conf_log="/tmp/conf.log"

function log()
{
	echo $1 >> $conf_log
}

function check_db()
{
	/usr/bin/php7.4 ./try_db.php
	return $?
}

while check_db; do
	echo "Database check failed, retrying..."
	sleep 1
done

if [ ! -f $wp_is_setup ]; then
	mkdir -p $WP_PATH
	curl -s https://wordpress.org/$wp_archive --output $wp_archive
	tar -xvf $wp_archive >> $conf_log
	rm -rf $wp_archive
	mv wordpress/* $WP_PATH
	rm -rf wordpress
	cd $WP_PATH
	cp wp-config-sample.php wp-config.php
	sed -i "s|database_name_here|$MYSQL_DB|g" wp-config.php
	sed -i "s|username_here|$MYSQL_USER|g" wp-config.php
	sed -i "s|password_here|$MYSQL_PASS|g" wp-config.php
	sed -i "s|localhost|$MYSQL_HOST|g" wp-config.php
	touch $wp_is_setup
fi

if [ ! -d /run/php/ ]; then
	sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf
	mkdir -p /run/php/
fi

php-fpm7.4 -F
