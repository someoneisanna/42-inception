FROM debian:bullseye

EXPOSE 443

RUN apt-get update \ 
	&& apt-get install -y \
		nginx \
		openssl \
		curl \
		wget \
		telnet \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/cert.key \
		-out /etc/nginx/cert.crt \
    	-subj "/C=PT/ST=Porto/L=Porto/O=42/CN=ataboada.42.fr"

CMD ["nginx", "-g", "daemon off;"]
