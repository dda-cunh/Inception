FROM		debian:bullseye

RUN			apt-get update -y \
			&& apt-get upgrade -y \
			&& apt-get install -y \
				curl \
				php-fpm \
				php-mysql \
			&& apt-get clean

WORKDIR		/service

COPY		./config/* ./

ENTRYPOINT	[ "bash", "script.sh" ]
