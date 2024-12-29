FROM	debian:bullseye

RUN		apt-get update -y \
		&& apt-get upgrade -y \
		&& apt-get install -y \
			mariadb-server \
		&& apt-get clean

WORKDIR	/service

COPY	./config/script.sh ./

CMD 	[ "bash", "script.sh" ]
