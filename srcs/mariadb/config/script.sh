#!/bin/bash

if [ ! -d "/var/lib/mysql/${MYSQL_DB}" ]; then
	service mariadb start

	while ! mysqladmin ping --silent; do
		echo "Waiting for MariaDB to start..."
		sleep 3
	done

	if mysql -u root -e "
		DELETE FROM mysql.user WHERE User='' AND Host='localhost';
		DELETE FROM mysql.user WHERE User='' AND Host='$(hostname)';
		DROP DATABASE IF EXISTS test;
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';
		CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};
		CREATE USER IF NOT EXISTS '${MYSQL_UNAME}'@'%' IDENTIFIED BY '${MYSQL_UPASS}';
		GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_UNAME}'@'%';
		FLUSH PRIVILEGES;
	"; then
		echo "Database initialized successfully."
	else
		echo "Database initialization failed!" >&2
		exit 1
	fi

	service mariadb stop

	sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
fi

mysqld_safe
