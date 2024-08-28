# Use the official Debian Bullseye image as the base image where Wordpress will
# be installed on.
FROM		debian:bullseye

# Tell docker which port the container will be listening on. 
# This is informational and does not actually publish the port.
EXPOSE		9000

# Update the package list and install the necessary packages for running 
# WordPress and PHP-FPM, including tools for downloading and extracting files.
# We will then clean up the package list and remove the cache.
RUN			apt-get update \
			&& apt-get install -y \
				php7.4-fpm \
				php7.4-mysql \
				mariadb-client \
				wget \
				tar \
			&& apt-get clean \
			&& rm -rf /var/lib/apt/lists/*

# Create the directory where WordPress will be installed.
RUN			mkdir -p /var/www/

# Download and extract the latest version of WordPress.
RUN			wget -O /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz \
			&& tar -xvf /tmp/latest.tar.gz -C /var/www/ \
			&& rm /tmp/latest.tar.gz

# Set proper ownership for WordPress files. www-data is a user conventionally 
# used by Apache and Nginx web servers.
# This is needed to allow WordPress to write to the directory.
RUN			chown -R www-data:www-data /var/www/wordpress

# Copy PHP-FPM pool configuration file to use our custom configuration.
# This configures PHP-FPM to run as www-data and listen on port 9000.
COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy the WordPress configuration file to use our custom configuration.
# This file contains database connection details and some WordPress settings.
COPY		conf/wp-config.php /var/www/wordpress/wp-config.php

# Copy the script that will be executed to the appropriate directory in the 
# container, then make it executable.
COPY		tools/setup.sh /tmp/
RUN			chmod +x /tmp/setup.sh

# Set the entrypoint to run the setup script which performs additional WordPress
# configuration and starts the PHP-FPM server as a new process, replacing the 
# script with php-fpm7.4 (using exec $@).
ENTRYPOINT	["/tmp/setup.sh", "php-fpm7.4", "--nodaemonize"]
