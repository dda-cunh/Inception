#!/bin/bash

if [ ! -f /service/.mysql_is_setup ]; then
	service mariadb start

	mysql -u root -e "
					DELETE FROM mysql.user WHERE User='' AND Host='localhost';
					DELETE FROM mysql.user WHERE User='' AND Host='$(hostname)';
					DROP DATABASE IF EXISTS test;
					ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';
					CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};
					CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';
					GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'%';
					FLUSH PRIVILEGES;
				"

	service mariadb stop

	touch /service/.mysql_is_setup
fi

mysqld_safe --bind-address=0.0.0.0
