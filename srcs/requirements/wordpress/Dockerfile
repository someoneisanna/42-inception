# Use the official Debian Bullseye image as the base image where MariaDB will be installed on.
FROM		debian:bullseye

# Tell docker which port the container will be listening on. This is informational and does not actually publish the port.
EXPOSE		9000

# Update the package list and install PHP and MariaDB client. We will then clean up the package list and remove the cache.
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

# Download the latest version of WordPress, extract it, and remove the archive.
RUN			wget -O /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz \
			&& tar -xvf /tmp/latest.tar.gz -C /var/www/ \
			&& rm /tmp/latest.tar.gz

# Change the owner of the WordPress directory to www-data. This is needed to allow WordPress to write to the directory.
RUN			chown -R www-data:www-data /var/www/wordpress

# Copy the configuration files to the appropriate directories.
# The www.conf file is used to configure the PHP-FPM pool. This is needed to allow PHP-FPM to listen on the network and change the user and group to www-data so that WordPress can write to the directory.
COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# The wp-config.php file is used to configure the WordPress database connection. This is needed to allow WordPress to connect to the MariaDB database.
COPY		conf/wp-config.php /var/www/wordpress/wp-config.php

# Copy the script that will be executed when the container starts, then make it executable.
COPY		tools/setup.sh /tmp/
RUN			chmod +x /tmp/setup.sh

# This runs the setup script when the container starts, which in turn starts the PHP-FPM server.
ENTRYPOINT ["/tmp/setup.sh", "php-fpm7.4", "--nodaemonize"]
