FROM		debian:bullseye

EXPOSE		443

RUN			apt-get update \
			&& apt-get install -y \
				nginx \
				openssl \
			&& rm -rf /var/lib/apt/lists/*

RUN			openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
				-keyout /etc/ssl/private/nginx-selfsigned.key \
				-out /etc/ssl/certs/nginx-selfsigned.crt \
				-subj "/C=PT/ST=Porto/L=Porto/O=42/OU=42/CN=ataboada.42.fr"

COPY		files/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT	["nginx", "-g", "daemon off;"]
