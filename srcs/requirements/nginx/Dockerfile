# Use the official Debian Bullseye image as the base image where MariaDB will be installed on.
FROM	debian:bullseye

# Tell docker which port the container listens on at runtime.
EXPOSE	443

# Update the package list and install Nginx, OpenSSL, Curl, Wget, and Telnet. We will then clean up the package list and remove the cache.
RUN		apt-get update \ 
		&& apt-get install -y \
			nginx \
			openssl \
			curl \
			wget \
			telnet \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

# Copy the configuration files to the appropriate directories, replacing the old configuration file with the new one.
COPY	conf/nginx.conf /etc/nginx/nginx.conf

# Generate a self-signed SSL certificate. It will be stored in the /etc/nginx directory.
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/cert.key \
		-out /etc/nginx/cert.crt \
		-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCATION}/O=${ORGANIZATION}/CN=${COMMON_NAME}"

# Run Nginx in the foreground. This is needed to keep the container running.
CMD ["nginx", "-g", "daemon off;"]
