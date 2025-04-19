FROM	debian:bullseye

RUN		apt-get update -y \
		&& apt-get upgrade -y \
		&& apt-get install -y \
			nginx \
			openssl \
		&& apt-get clean \
		&& mkdir -p /etc/nginx/ssl \
		&& openssl req -x509 -nodes -days 365 \
			-newkey rsa:2048 \
			-keyout /etc/nginx/ssl/ssl.key \
			-out /etc/nginx/ssl/ssl.crt \
			-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42Lisboa/OU=Student/CN=dda-cunh.42.fr/UID=dda-cunh"

COPY	./config/nginx.conf	/etc/nginx/conf.d/nginx.conf

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
