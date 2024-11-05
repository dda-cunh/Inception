FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get upgrade -y


COPY ./tools/script.sh /app/

WORKDIR /app

CMD ["bash", "script.sh"]
