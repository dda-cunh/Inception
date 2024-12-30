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

RUN		echo "\
			events {}\
			http\
			{\
				server\
				{\
					listen 443 ssl;\
					server_name dda-cunh.42.fr;\
			\
					ssl_certificate_key /etc/nginx/ssl/ssl.key;\
					ssl_certificate /etc/nginx/ssl/ssl.crt;\
					ssl_protocols TLSv1.3;\
			\
					root /var/www/wordpress;\
					index index.html;\
			\
					location ~ \.php$\
					{\
						include snippets/fastcgi-php.conf;\
						fastcgi_pass wordpress:9000;\
					}\
				}\
			}\
			" > /etc/nginx/nginx.conf

CMD		[ "nginx", "-g", "daemon off;" ]
