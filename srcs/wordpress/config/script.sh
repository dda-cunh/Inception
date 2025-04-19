#!/bin/bash

wp_is_setup=$WP_PATH/"wp-config.php"
wp_bin="/usr/local/bin/wp"

if [ ! -f $wp_bin ];
then
	curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar $wp_bin
fi

if [ ! -d $wp_is_setup ]; then
	cd $WP_PATH
	wp core download --allow-root
	wp config create --allow-root \
						--dbname=$MYSQL_DB \
						--dbuser=$MYSQL_UNAME \
						--dbpass=$MYSQL_UPASS \
						--dbhost=$WP_MYSQL_HOST
	wp core install	--allow-root \
						--url=$WP_URL \
						--title=$WP_TITLE \
						--admin_user=$WP_ADMNAME \
						--admin_password=$WP_ADMPASS \
						--admin_email=$WP_ADMMAIL
	wp user create --allow-root \
						$WP_UNAME $WP_UMAIL  \
						--role=$WP_UROLE \
						--user_pass=$WP_UPASS
	wp theme install $WP_THEME --allow-root \
						--activate 
fi

if [ ! -d /run/php/ ]; then
	sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf
	mkdir -p /run/php/
fi

php-fpm7.4 -F
