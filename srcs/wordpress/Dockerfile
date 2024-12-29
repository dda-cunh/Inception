FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get upgrade -y


COPY ./config/script.sh /app/

WORKDIR /app

CMD ["bash", "script.sh"]
