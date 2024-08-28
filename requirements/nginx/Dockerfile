# Use the official Debian Bullseye image as the base image where Nginx will 
# be installed on.
FROM	debian:bullseye

# Tell docker which port the container will be listening on. 
# This is informational and does not actually publish the port.
EXPOSE	443

# Update the package list and install  Nginx and necessary tools.
# OpenSSL is used for SSL certificate generation.
# Curl, wget, and telnet are used for testing the Nginx server.
# We will then clean up the package list and remove the cache.
RUN		apt-get update \ 
		&& apt-get install -y \
			nginx \
			openssl \
			curl \
			wget \
			telnet \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

# Replace the default Nginx configuration with our custom configuration.
COPY	conf/nginx.conf /etc/nginx/nginx.conf

# Generate a self-signed SSL certificate. 
# This is needed to enable HTTPS on the Nginx server.
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/cert.key \
		-out /etc/nginx/cert.crt \
		-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCATION}/O=${ORGANIZATION}/CN=${COMMON_NAME}"

# Run Nginx in the foreground. This is needed to keep the container running.
CMD		["nginx", "-g", "daemon off;"]
