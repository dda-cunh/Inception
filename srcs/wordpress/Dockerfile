FROM	debian:bullseye

RUN		apt-get update -y \
		&& apt-get upgrade -y \
		&& apt-get install -y \
			curl \
			php-fpm \
		&& apt-get clean \
		&& mkdir -p /var/www/html/

WORKDIR	/service

COPY	./config/script.sh ./

CMD		[ "bash", "script.sh" ]
