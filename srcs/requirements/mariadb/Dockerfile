# Use the official Debian Bullseye image as the base image where MariaDB will be installed on.
FROM		debian:bullseye

# Describe which port the container will be listening on. This is informational and does not actually publish the port.
EXPOSE		3306

# Update the package list and install MariaDB. We will then clean up the package list and remove the cache.
RUN			apt-get update \
			&& apt-get install -y mariadb-server \
			&& apt-get clean \
			&& rm -rf /var/lib/apt/lists/*

# Change the default configuration file to the one we made. This is needed to allow remote connections to the database.
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy the script that will be executed when the container starts, then make it executable.
COPY		tools/setup.sh /usr/local/bin/
RUN			chmod +x /usr/local/bin/setup.sh

# This runs the setup script when the container starts, which in turn starts the MariaDB server.
CMD			["/usr/local/bin/setup.sh", "mysqld"]
