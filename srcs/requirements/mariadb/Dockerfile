FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server

COPY ./config/script.sh /app/

WORKDIR /app

CMD ["bash", "script.sh"]
