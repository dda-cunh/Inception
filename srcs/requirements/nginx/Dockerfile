FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install nginx -y \
	&& apt install OpenSSL -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=42/CN=dda-cunh.42.fr/UID=dda-cunh"

COPY ./config/nginx.conf /etc/nginx/nginx.conf

COPY ./config/script.sh /app/

WORKDIR /app

CMD ["sh", "script.sh"]
