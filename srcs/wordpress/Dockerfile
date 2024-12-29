FROM	debian:bullseye

RUN		apt-get update -y \
		&& apt-get upgrade -y

COPY	./config/script.sh /service/

WORKDIR	/service

CMD		[ "bash", "script.sh" ]
